import 'package:dio/dio.dart';
import 'package:el_grocer/configuration/configuration.dart';
import 'package:el_grocer/domain/api_client/network_client.dart';
import 'package:el_grocer/domain/entity/product.dart';

class ProductApiClient {

  String getImage(String? posterPath) {
    return "${Configuration.host}/get/product/image/$posterPath";
  }

  Future<List<Product>> getAllProducts(String? search) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      List<dynamic> list = jsonMap['products'];
      List<Product> response = list.map((e) => Product.fromJson(e)).toList();
      return response;
    }

    final result =
        await NetworkClient.get("/get/products", parser, {"search": search});
    return result;
  }

  Future<List<Product>> getLimitProducts(int? limit) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      List<dynamic> list = jsonMap['products'];
      List<Product> response = list.map((e) => Product.fromJson(e)).toList();
      return response;
    }

    final result = await NetworkClient.get("/get/products", parser, {
      "limit": limit,
    });
    return result;
  }

  Future<List<Product>> getProductByCategory(int? categoryId) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      List<dynamic> list = jsonMap['products'];
      List<Product> response = list.map((e) => Product.fromJson(e)).toList();
      return response;
    }

    final result = await NetworkClient.get(
      "/get/products/$categoryId",
      parser,
    );
    return result;
  }
}
