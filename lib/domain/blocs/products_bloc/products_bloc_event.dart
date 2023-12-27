abstract class ProductsBlocEvent {

}


class GetAllProductsEvent extends ProductsBlocEvent {

}

class GetLimitProductEvent extends ProductsBlocEvent {

}


class GetProductByCategoryEvent extends ProductsBlocEvent {
  final int? categoryId;
  GetProductByCategoryEvent({required this.categoryId});
}

class GetSearchProductEvent extends ProductsBlocEvent {
  String? searchText;
  GetSearchProductEvent({required this.searchText});
}