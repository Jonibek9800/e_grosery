import 'package:el_grocer/domain/api_client/product_api.dart';
import 'package:el_grocer/domain/blocs/products_bloc/products_bloc_event.dart';
import 'package:el_grocer/domain/blocs/products_bloc/products_bloc_model.dart';
import 'package:el_grocer/domain/blocs/products_bloc/products_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsBloc extends Bloc<ProductsBlocEvent, ProductsBlocState> {
  late ProductsBlocModel currentState;

  ProductsBloc()
      : super(InitProductsState(productsBlocModel: ProductsBlocModel())) {
    currentState = state.productsBlocModel;

    final productsApiClient = ProductApiClient();
    on<GetAllProductsEvent>((event, emit) async {
      try {
        currentState.allProducts = await productsApiClient.getAllProducts(null);
        emit(GetAllProductsState(productsBlocModel: currentState));
      } catch (e) {
        emit(ErrorProductsState(productsBlocModel: currentState));
      }
    });
    on<GetLimitProductEvent>((event, emit) async {
      try {
        currentState.filteredProducts = [];
        currentState.limitProducts =
            await productsApiClient.getLimitProducts(8);
        emit(GetLimitProductsState(productsBlocModel: currentState));
      } catch (e) {
        emit(ErrorProductsState(productsBlocModel: currentState));
      }
    });
    on<GetSearchProductEvent>((event, emit) async {
      try {
        currentState.filteredProducts =
            await productsApiClient.getAllProducts(event.searchText);
        emit(GetSearchProductsState(productsBlocModel: currentState));
      } catch (e) {
        emit(ErrorProductsState(productsBlocModel: currentState));
      }
    });
    on<GetProductByCategoryEvent>((event, emit) async {
      try {
        currentState.productByCategory = [];
        currentState.productByCategory =
            await productsApiClient.getProductByCategory(event.categoryId);
        emit(GetProductsByCategoryState(productsBlocModel: currentState));
      } catch (e) {
        emit(ErrorProductsState(productsBlocModel: currentState));
      }
    });
  }
}
