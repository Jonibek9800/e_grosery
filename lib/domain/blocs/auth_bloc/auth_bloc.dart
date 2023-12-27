import 'package:bloc/bloc.dart';
import 'package:el_grocer/domain/entity/user.dart';
import 'package:flutter/cupertino.dart';

import '../../api_client/auth_api_client.dart';
import '../../data_provider/session_data_provider.dart';
import 'auth_event.dart';
import 'auth_model.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final _sessionDataProvider = SessionDataProvider();
  final authApiClient = AuthApiClient();

  AuthBloc() : super(AuthInitState(authModel: AuthModel())) {
    on<AuthAuthorizedEvent>((event, emit) => onAuthorizedState(emit, event));
    on<AuthLogoutEvent>((event, emit) => onLogoutEvent(emit, event));
    on<UpdateUserEvent>((event, emit) => onUpdateEvent(emit, event));
    on<EditUserEvent>((event, emit) => onEditUser(emit, event));
    on<CreateUserEvent>((event, emit) => onCreateUser(emit, event));
  }

  void onAuthorizedState(Emitter emit, event) async {
    final currentState = state.authModel;
    try {
      currentState.errorMessage = null;
      emit(AuthFailureState(authModel: currentState));
      emit(AuthLoadState(authModel: currentState));
      final sessionId = await authApiClient.auth(
          email: event.login, password: event.password);
      if (sessionId.containsKey("serverError")) {
        currentState.errorMessage = sessionId['message'];
        emit(AuthFailureState(authModel: currentState));
      } else if (sessionId.containsKey("status") &&
          sessionId['status'] == true) {
        currentState.user = sessionId['user'];
        await _sessionDataProvider.setSessionId(sessionId['token']);
        emit(AuthAuthorizedState(authModel: currentState));
      } else if (sessionId.containsKey("status") &&
          sessionId['status'] == false) {
        currentState.errorMessage = sessionId['message'];
        emit(AuthFailureState(authModel: currentState));
      } else {
        currentState.errorMessage = sessionId['message'];
        emit(AuthFailureState(authModel: currentState));
      }
    } catch (error) {
      currentState.errorMessage = "Unknown error try again later!";
      emit(AuthFailureState(authModel: currentState));
    }
  }

  void onLogoutEvent(Emitter emit, event) async {
    final current = state.authModel;
    await authApiClient.logout();
    await _sessionDataProvider.setSessionId(null);
    emit(AuthUnAuthorizedState(authModel: current));
  }

  void onUpdateEvent(Emitter emit, event) async {
    final currentState = state.authModel;
    try {
      emit(AuthLoadState(authModel: currentState));
      final user = await authApiClient.updateUser(
        userId: event.userId,
        name: event.name,
        email: event.email,
        phoneNumber: event.phoneNumber,
      );
      currentState.user = user;
      emit(UpdateUserState(authModel: currentState));
    } catch (err) {
      currentState.errorMessage = "Failed to update user";
      emit(AuthFailureState(authModel: currentState));
    }
  }

  void onEditUser(Emitter emit, event) {
    final currentState = state.authModel;
    emit(AuthLoadState(authModel: currentState));
    currentState.editName.text = event.user['name'];
    currentState.editEmail.text = event.user['email'];
    currentState.editPhoneNumber.text = event.user['phone_number'] ?? "";
    emit(EditUserState(authModel: currentState));
  }

  void onCreateUser(Emitter emit, event) async {
    final currentState = state.authModel;
    try {
      emit(AuthLoadState(authModel: currentState));
      final data = await authApiClient.createUser(
        name: event.name,
        email: event.email,
        phoneNumber: event.phoneNumber,
        password: event.password,
        confirmPassword: event.confirmPassword,
      );
      await _sessionDataProvider.setSessionId(data['token']);
      currentState.user = data['user'];
      emit(CreateUserState(authModel: currentState));
      emit(AuthAuthorizedState(authModel: currentState));
    } catch (err) {
      emit(AuthFailureState(authModel: currentState));
    }
  }
}
