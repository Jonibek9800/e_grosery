import 'package:flutter/cupertino.dart';

import '../../entity/user.dart';

class AuthModel {
  String? name;
  String? email;
  String? phoneNumber;
  String? password;
  String? confirmPassword;

  Map<String, dynamic>? user;

  final editName = TextEditingController(text: "");
  final editEmail = TextEditingController(text: "");
  final editPhoneNumber = TextEditingController(text: "");

  String? errorMessage;
}
