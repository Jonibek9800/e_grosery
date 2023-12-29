import 'package:el_grocer/domain/blocs/favorite_cubit/favorite_model.dart';

class FavoriteCubitState {
  FavoriteModel favoriteModel;

  FavoriteCubitState({required this.favoriteModel});
}

class InitialFavoriteState extends FavoriteCubitState {
  InitialFavoriteState({required FavoriteModel favoriteModel})
      : super(favoriteModel: favoriteModel);
}
