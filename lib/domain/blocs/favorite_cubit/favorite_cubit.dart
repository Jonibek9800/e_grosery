import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:el_grocer/domain/api_client/favorite_api.dart';
import 'package:el_grocer/domain/blocs/favorite_cubit/favorite_cubit_state.dart';
import 'package:el_grocer/domain/blocs/favorite_cubit/favorite_model.dart';
import 'package:el_grocer/domain/entity/favorite.dart';
import 'package:el_grocer/domain/entity/product.dart';
import 'package:flutter/cupertino.dart';

class FavoriteCubit extends Cubit<FavoriteCubitState> {
  FavoriteCubit() : super(InitialFavoriteState(favoriteModel: FavoriteModel()));

  void toggleFavorite(userId, Product? product) async {
    try {
      final current = state.favoriteModel;
      if ((product?.checkFavoriteInServer ?? false)) return;
      var favorite = current.favoriteList
          .firstWhereOrNull((element) => element.productId == product?.id);
      product?.isInFavorite = !product.isInFavorite;
      emit(InitialFavoriteState(favoriteModel: current));
      await product?.getIsFavorite(userId);
      emit(InitialFavoriteState(favoriteModel: current));
      if ((product?.isInFavorite ?? false) && favorite == null) {
        current.favoriteList.add(
            Favorite(userId: userId, productId: product?.id, product: product));
      } else {
        current.favoriteList
            .removeWhere((element) => element.productId == product?.id);
      }
      // getFavorite(userId);
      emit(InitialFavoriteState(favoriteModel: current));
    } catch (err) {
      print("cubit method error: $err");
    }
  }

  void getFavorite(userId) async {
    Product product;
    try {
      final current = state.favoriteModel;
      final data = await FavoriteApi.getFavoriteProducts(userId: userId);
      debugPrint("success from get request: ${data["favorite_products"]}");
      List<dynamic> favoritesList = data['favorite_products'];
      for (var favorite in favoritesList) {
        current.favoriteList.add(Favorite.fromJson(favorite));
      }

      emit(InitialFavoriteState(favoriteModel: current));
    } catch (err) {
      debugPrint("error from get request: $err");
    }
  }
}
