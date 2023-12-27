import 'network_client.dart';

class AuthApiClient {
  Future<Map<String, dynamic>> auth({
    required email,
    required String password,
  }) async {
    Map<String, dynamic> result = {};
    try {
      final params = {"email": email, 'password': password};
      final sessionId =
          await NetworkClient.dio.post("/auth/login", queryParameters: params);

      if (sessionId.statusCode != 200) return {"serverError": true};

      result = sessionId.data;
    } catch (err) {
      result["serverError"] = true;
    }
    return result;
  }

  Future<Map<String, dynamic>> updateUser(
      {required userId, name, email, phoneNumber}) async {
    Map<String, dynamic> result = {};
    try {
      final params = {
        "name": name,
        "email": email,
        "phone_number": phoneNumber
      };

      final response = await NetworkClient.dio
          .put("/update/$userId", queryParameters: params);

      if (response.statusCode != 200) return {"serverError": true};

      result = response.data['user'];
    } catch (err) {
      result = {"error": err};
    }
    return result;
  }

  Future<Map<String, dynamic>> createUser(
      {required name,
      required email,
      phoneNumber,
      required password,
      required confirmPassword}) async {
    Map<String, dynamic> result = {};
    try {
      final params = {
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "password": password,
        "confirm_password": confirmPassword
      };
      final response = await NetworkClient.dio
          .post("/auth/register", queryParameters: params);
      if (response.statusCode != 200) return {"serverError": true};
      result = response.data;
    } catch (err) {
      result = {"error": err};
    }
    return result;
  }

  Future<String> logout() async {
    final response = await NetworkClient.dio.get("/logout");

    return response.data['message'];
  }

  Future<Map<String, dynamic>?> getToken() async {
    Map<String, dynamic>? result = {};
    try {
      final params = await NetworkClient.dio.get("/get/token");

      if (params.statusCode != 200) return {"serverError": true};
      result = params.data['user'];
    } catch (err) {
      result = {"error": err};
    }
    return result;
  }
}
