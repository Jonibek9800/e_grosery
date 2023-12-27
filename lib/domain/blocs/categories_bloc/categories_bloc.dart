import 'package:bloc/bloc.dart';
import 'package:el_grocer/domain/blocs/categories_bloc/categories_bloc_model.dart';
import 'package:el_grocer/domain/blocs/categories_bloc/categories_event.dart';
import 'package:el_grocer/domain/blocs/categories_bloc/categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc()
      : super(LoadingCategoriesState(
            categoriesBlocModel: CategoriesBlocModel())) {
    on<AddCategoriesEvent>((event, emit) => null);

    on<LoadFromServerEvent>((event, emit) async {
      var currentState = state.categoriesBlocModel;

      try {
        emit(LoadingCategoriesState(categoriesBlocModel: currentState));

        await currentState.getCategories();
        await currentState.getAllCategories();
        emit(InitCategoriesState(categoriesBlocModel: currentState));
      } catch (e) {
        emit(ErrorCategoriesState(categoriesBlocModel: currentState));
      }
    });
  }
}
