import 'package:el_grocer/domain/api_client/category_api.dart';
import 'package:el_grocer/domain/entity/category.dart';
import 'package:flutter/cupertino.dart';

class CategoriesBlocModel {
  final _categoryApiClient = CategoryApiClient();
  List<Category> categories = [];
  List<Category> allCategories = [];

  getCategories() async {
    categories = await _categoryApiClient.getLimitCategories();
  }

  getAllCategories() async {
      allCategories = await _categoryApiClient.getAllCategories();
  }

  returnCategoryByName(categories, categoryName) {
    return categories.where((category) => category.title == categoryName).toList();
  }
}
