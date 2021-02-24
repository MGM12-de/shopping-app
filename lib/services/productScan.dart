import 'dart:convert';

import 'package:http/http.dart' as http;

class Product {
  static String productDBUrl = "https://de.openfoodfacts.org/api/v0/product";
  final String barCode;

  Product({this.barCode});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(barCode: json['code']);
  }

  static Future<Product> fetchProduct(barcode) async {
    final response = await http.get('$productDBUrl/$barcode');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Product.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
