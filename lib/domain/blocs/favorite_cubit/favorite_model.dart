import 'package:el_grocer/domain/entity/favorite.dart';

class FavoriteModel {
  List<Favorite> favoriteList = [];
  
  
  bool isFavorite(product) {
    return favoriteList.any((element) => element.productId == product.id);
  }
}