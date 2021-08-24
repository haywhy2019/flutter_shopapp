import 'dart:convert';

import 'package:flutter/cupertino.dart';
import "package:http/http.dart" as http;
import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    final url = Uri.parse(
        'https://ecom-db-ef01d-default-rtdb.firebaseio.com/products/$id.json');
    try {
      await http.patch(url,
          body: json.encode({
            "isFavorite": isFavorite,
          }));
      notifyListeners();
    } catch (error) {
      isFavorite = oldStatus;
    }
  }
}
