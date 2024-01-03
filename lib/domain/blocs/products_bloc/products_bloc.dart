import 'dart:developer';

import 'package:el_grocer/domain/api_client/product_api.dart';
import 'package:el_grocer/domain/blocs/products_bloc/products_bloc_event.dart';
import 'package:el_grocer/domain/blocs/products_bloc/products_bloc_model.dart';
import 'package:el_grocer/domain/blocs/products_bloc/products_bloc_state.dart';
import 'package:el_grocer/domain/entity/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsBloc extends Bloc<ProductsBlocEvent, ProductsBlocState> {
  late ProductsBlocModel currentState;

  ProductsBloc() : super(InitProductsState(productsBlocModel: ProductsBlocModel())) {
    currentState = state.productsBlocModel;

    final productsApiClient = ProductApiClient();
    on<GetAllProductsEvent>((event, emit) async {
      try {
        currentState.allProducts.clear();
        currentState.currentPage = 1;
        emit(GetAllProductsState(productsBlocModel: currentState));
        final response =
            await productsApiClient.getAllProducts(null, currentState.currentPage, 'id', 'asc');
        log("$response");
        var productList = (response['data'] as List).map((e) => Product.fromJson(e)).toList();
        currentState.addAndPagination(list: productList);
        currentState.totalCount = response['total'];
        emit(GetAllProductsState(productsBlocModel: currentState));
      } catch (e) {
        emit(ErrorProductsState(productsBlocModel: currentState));
      }
    });
    on<GetLimitProductEvent>((event, emit) async {
      try {
        currentState.filteredProducts = [];
        currentState.limitProducts = await productsApiClient.getLimitProducts(8, 'id', 'asc');
        emit(GetLimitProductsState(productsBlocModel: currentState));
      } catch (e) {
        emit(ErrorProductsState(productsBlocModel: currentState));
      }
    });
    on<GetSearchProductEvent>((event, emit) async {
      try {
        final response = await productsApiClient.getAllProducts(
          currentState.searchController.text,
          null,
          event.sortName,
          event.sortMethod,
        );
        currentState.filteredProducts =
            (response['data'] as List).map((e) => Product.fromJson(e)).toList();
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
    on<GetNextProductPageEvent>((event, emit) async {
      // if (event.index <= (currentState.totalCount ?? 0)) return;
      // if (event.index == currentState.allProducts.length - 1) {
      if (currentState.allProducts.length >= (currentState.totalCount ?? 0)) return;

      final response = await productsApiClient.getAllProducts(
        null,
        currentState.currentPage,
        event.sortName,
        event.sortMethod,
      );
      // currentState.currentPage = response["current_page"];
      final allProducts = (response['data'] as List).map((e) => Product.fromJson(e)).toList();

      currentState.addAndPagination(list: allProducts, pagination: true);
      // }
      debugPrint("${currentState.allProducts}");
      emit(GetNextProductPageState(productsBlocModel: currentState));
    });
    on<SpeechToTextControllerEvent>((event, emit) async {
      currentState.searchController.text = event.text ?? "";
      final response = await productsApiClient.getAllProducts(
        currentState.searchController.text,
        null,
        event.sortName,
        event.sortMethod,
      );
      currentState.filteredProducts =
          (response['data'] as List).map((e) => Product.fromJson(e)).toList();
      emit(InitProductsState(productsBlocModel: currentState));
    });
  }
}
