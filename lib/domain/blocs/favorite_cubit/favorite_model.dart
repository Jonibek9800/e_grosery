import 'package:el_grocer/domain/entity/favorite.dart';

class FavoriteModel {
  List<Favorite> favoriteList = [];
  
  
  bool isFavorite(productId) {
    return favoriteList.any((element) => element.productId == productId);
  }
}