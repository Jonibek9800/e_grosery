import 'package:el_grocer/domain/api_client/network_client.dart';
import 'package:el_grocer/domain/entity/category.dart';

import '../../configuration/configuration.dart';

class CategoryApiClient {

Future<List<Category>> getLimitCategories() async {
  const limit = 6;
  parser(dynamic json) {
    final jsonMap = json as Map<String, dynamic>;
    List<dynamic> list = jsonMap['categories'];
    List<Category> response = list.map((e) => Category.fromJson(e)).toList();
    return response;
  }

  final result = await NetworkClient.get(
    "/get/categories",
    parser,
    {
      "limit": limit
    },
  );
  return result;
}

String getCategoryImage(String? posterPath) {
  return "${Configuration.host}/get/category/image/$posterPath";
}

Future<List<Category>> getAllCategories() async {
  parser(dynamic json) {
    final jsonMap = json as Map<String, dynamic>;
    List<dynamic> list = jsonMap['categories'];
    List<Category> response = list.map((e) => Category.fromJson(e)).toList();
    return response;
  }

  final result = await NetworkClient.get(
    "/get/categories",
    parser,
  );
  return result;
}
}