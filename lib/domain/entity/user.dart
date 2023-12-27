class User {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? password;
  String? confirmPassword;
  DateTime? createdAt;
  DateTime? updatedAt;

  User(
      {this.id,
        this.name,
        this.email,
        this.phoneNumber,
        this.password,
        this.confirmPassword,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['first_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    password = json['password'];
    confirmPassword = json['confirm_password'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = name;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['password'] = password;
    data['confirm_password'] = confirmPassword;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
