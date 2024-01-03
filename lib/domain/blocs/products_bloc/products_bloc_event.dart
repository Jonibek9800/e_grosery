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
}

class GetNextProductPageEvent extends ProductsBlocEvent {
}

class SpeechToTextControllerEvent extends ProductsBlocEvent {
  String? text;
  SpeechToTextControllerEvent({required this.text});
}