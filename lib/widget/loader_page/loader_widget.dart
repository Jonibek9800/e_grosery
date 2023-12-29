import 'package:el_grocer/domain/blocs/categories_bloc/categories_event.dart';
import 'package:el_grocer/domain/blocs/favorite_cubit/favorite_cubit.dart';
import 'package:el_grocer/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/api_client/auth_api_client.dart';
import '../../domain/api_client/network_client.dart';
import '../../domain/blocs/auth_bloc/auth_bloc.dart';
import '../../domain/blocs/auth_bloc/auth_state.dart';
import '../../domain/blocs/cart_blocs/cart_bloc.dart';
import '../../domain/blocs/cart_blocs/cart_bloc_event.dart';
import '../../domain/blocs/categories_bloc/categories_bloc.dart';
import '../../domain/blocs/products_bloc/products_bloc.dart';
import '../../domain/blocs/products_bloc/products_bloc_event.dart';
import 'loader_view_cubit.dart';

class LoaderWidget extends StatefulWidget {
  const LoaderWidget({super.key});

  @override
  State<LoaderWidget> createState() => _LoaderWidgetState();
}

class _LoaderWidgetState extends State<LoaderWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // await Future.delayed(const Duration(seconds: 3));
      final state = context.read<LoaderViewCubit>().state;
      context.read<LoaderViewCubit>().emitState(state);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoaderViewCubit, LoaderViewCubitState>(
      // listenWhen: (prev, current) => current != LoaderViewCubitState.unknown,
      listener: (context, state) {
        _onLoaderViewCubitStateChange(context, state);
      },
      child: Scaffold(
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.green,
            child: const Center(
              child: Text(
                "eGrocer",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 72,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onLoaderViewCubitStateChange(
    BuildContext context,
    LoaderViewCubitState state,
  ) async {
    await NetworkClient.initDio();
    final user = await AuthApiClient().getToken();
    final authModel = context.read<AuthBloc>().state.authModel;
    authModel.user = user;
    context.read<AuthBloc>().emit(AuthUnAuthorizedState(authModel: authModel));

    final nextScreen = state != LoaderViewCubitState.unAuthorized
        ? MainNavigationRouteNames.mainPage
        : MainNavigationRouteNames.auth;
    Navigator.of(context).pushNamedAndRemoveUntil(nextScreen, (route) => false);
    context.read<CategoriesBloc>().add(LoadFromServerEvent());
    context.read<ProductsBloc>().add(GetLimitProductEvent());
    if (user != null) {
      context.read<CartBloc>().add(InitCartEvent());
      context.read<FavoriteCubit>().getFavorite(user['id']);
    } else {
      context.read<CartBloc>().state.cartBlocModel.cartProductList = [];
    }
  }
}
