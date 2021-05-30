import 'dart:convert';
import 'dart:ffi';
import 'dart:ui';

import 'package:einkaufsapp/services/models.dart';
import 'package:http/http.dart' as http;

class Product {
  static String productDBUrl =
      "https://<language>.openfoodfacts.org/api/v0/product";
  final String barCode;
  final String name;
  final String brand;
  final String pictureUrl;
  final String ingredients;
  final ProductScore scores;

  Product(
      {this.barCode,
      this.name,
      this.brand,
      this.pictureUrl,
      this.ingredients,
      this.scores});

  factory Product.fromJson(Map<String, dynamic> json) {
    Product product = Product(
        barCode: json['code'],
        name: json['product']['product_name'],
        brand: json['product']['brands'],
        pictureUrl: json['product']['image_url'] ?? '',
        ingredients: json['product']['ingredients_text'],
        scores: new ProductScore(
            nutri: json['product']['nutriscore_grade'] ?? 'unknown',
            eco: json['product']['ecoscore_grade'] ?? 'unknown'));
    return product;
  }

  static Future<Product> fetchProduct(Locale language, barcode) async {
    Uri url;
    if (language.languageCode != null) {
      productDBUrl =
          productDBUrl.replaceAll('<language>', language.languageCode);
    } else {
      productDBUrl = productDBUrl.replaceAll('<language>', "de");
    }

    print(productDBUrl);
    url = Uri.parse('$productDBUrl/$barcode');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Product.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load product');
    }
  }
}
