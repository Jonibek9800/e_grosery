import 'package:el_grocer/configuration/configuration.dart';
import 'package:el_grocer/domain/api_client/product_api.dart';
import 'package:el_grocer/domain/entity/category.dart';

class Product {
  int? id;
  String? posterPath;
  String? name;
  int? price;
  String? description;
  int? categoryId;
  int? favorite;
  String? createdAt;
  String? updatedAt;

  Product(
      {required this.id,
        this.posterPath,
        this.name,
        required this.price,
        this.description,
        required this.categoryId,
        this.favorite,
        this.createdAt,
        this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    posterPath = json['poster_path'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    categoryId = json['category_id'];
    favorite = json['favorite'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['poster_path'] = posterPath;
    data['name'] = name;
    data['price'] = price;
    data['description'] = description;
    data['category_id'] = categoryId;
    data['favorite'] = favorite;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  String getImage() {
    return ProductApiClient().getImage( posterPath);
  }
}