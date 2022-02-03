import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String decs;
  final String name;
  final String imgUrl;
  final String waitTime;
  final num score;
  final String cal;
  final double price;
  final num quantity;
  bool isFavorite;
  final String about;

  Product(
      {
      required this.id,
      required this.decs,
      required this.name,
      required this.imgUrl,
      required this.waitTime,
      required this.score,
      required this.cal,
      required this.price,
      required this.quantity,
      this.isFavorite = false,
      required this.about,
      });

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
