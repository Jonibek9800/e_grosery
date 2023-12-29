import 'package:el_grocer/domain/api_client/network_client.dart';

class FavoriteApi {
  static Future<Map<String, dynamic>> setFavoriteProduct({
    required userId,
    required productId,
  }) async {
    Map<String, dynamic> result = {};
    try {
      Map<String, dynamic> params = {
        "user_id": userId,
        "product_id": productId
      };
      final response = await NetworkClient.dio
          .post("/create/favorite", queryParameters: params);
      result = response.data;
    } catch (err) {
      result = {"error": err};
    }
    return result;
  }

  static Future<Map<String, dynamic>> getFavoriteProducts(
      {required userId}) async {
    Map<String, dynamic> result = {};
    try {
      final response = await NetworkClient.dio.get(
        "/get/favorite",
        queryParameters: {"user_id": userId},
      );
      result = response.data;
    } catch (err) {
      result = {"error": err};
    }
    return result;
  }

  static Future<void> removeFavorite({required userId, required productId}) async {
    await NetworkClient.dio
        .delete("/delete/favorite", queryParameters: {"user_id": userId, "product_id": productId});
  }
}
