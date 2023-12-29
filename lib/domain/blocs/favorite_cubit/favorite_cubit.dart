import 'package:bloc/bloc.dart';
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
      final index = current.favoriteList.indexWhere((element) => element.productId == product?.id);
      if (index == -1) {
        final data = await FavoriteApi.setFavoriteProduct(
            userId: userId, productId: product?.id);
        final favoriteProduct = data['favorite_product'];
        current.favoriteList.add(
          Favorite(
              id: favoriteProduct['id'],
              userId: userId,
              productId: product?.id,
              product: product,
              createdAt: favoriteProduct['created_at'],
              updatedAt: favoriteProduct['updated_at']),
        );
      } else {
        final newList = current.favoriteList
            .where((element) => element.productId != product?.id).toList();
        current.favoriteList = newList;
        await FavoriteApi.removeFavorite(userId: userId, productId: product?.id);
      }
      // getFavorite(userId);
      emit(InitialFavoriteState(favoriteModel: current));
    } catch (err) {
      print("cubit method error: $err");
    }
  }

  void getFavorite(userId) async {
    try {
      final current = state.favoriteModel;
      final data = await FavoriteApi.getFavoriteProducts(userId: userId);
      debugPrint("success from get request: ${data["favorite_products"]}");
      List<dynamic> favoritesList = data['favorite_products'];
      for (var favorite in favoritesList) {
        current?.favoriteList?.add(Favorite.fromJson(favorite));
      }

      emit(InitialFavoriteState(favoriteModel: current));
    } catch (err) {
      debugPrint("error from get request: $err");
    }
  }
}
