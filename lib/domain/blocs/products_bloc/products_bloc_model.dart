import 'package:el_grocer/domain/api_client/product_api.dart';
import 'package:el_grocer/domain/entity/product.dart';
import 'package:flutter/material.dart';

class ProductsBlocModel {
  final productsApiClient = ProductApiClient();
  FocusNode focusNode = FocusNode();

  List<Product> productByCategory = [];
  List<Product> allProducts = [];
  List<Product> limitProducts = [];
  List<Product> filteredProducts = [];


  // void getLimitProducts () async {
  //   limitProducts = await productsApiClient.getLimitProducts();
  // }
}