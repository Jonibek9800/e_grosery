import 'package:el_grocer/domain/api_client/product_api.dart';
import 'package:el_grocer/domain/entity/product.dart';
import 'package:el_grocer/utils/constans.dart';
import 'package:flutter/material.dart';

class ProductsBlocModel {
  final productsApiClient = ProductApiClient();
  FocusNode focusNode = FocusNode();

  List<Product> productByCategory = [];
  List<Product> allProducts = [];
  List<Product> limitProducts = [];
  List<Product> filteredProducts = [];
  int currentPage = 1;
  int? totalCount = 0;

  TextEditingController searchController = TextEditingController();

  // void getNextPage(int index) async {
  //
  // }

  void addAndPagination({required List<Product> list, bool pagination = false}) {
    if(pagination) {
      allProducts.addAll(list);
    } else {
      allProducts = list;
    }
    if(list.length >= Constans.purePage) {
      currentPage += 1;
    }
  }
}
