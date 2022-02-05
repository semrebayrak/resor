import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
        id: 'p5',
        decs: 'No1. in Sales',
        name: 'Chicken Cheese Burger',
        imgUrl: 'https://i.hizliresim.com/fmg455u.png',
        waitTime: '15min',
       cal: '425',
        price: 8,
        score: 4.3,
        about:
            'A cheeseburger is a hamburger topped with cheese. Traditionally, the slice of cheese is placed on top of the meat patty. The cheese is usually added to the cooking hamburger patty shortly before serving, which allows the cheese to melt.'),
            Product(
        id: 'p5',
        decs: 'No1. in Sales',
        name: 'Chicken Cheese Burger',
        imgUrl: 'https://i.hizliresim.com/fmg455u.png',
        waitTime: '15min',
       cal: '425',
        price: 8,
        score: 4.3,
        about:
            'A cheeseburger is a hamburger topped with cheese. Traditionally, the slice of cheese is placed on top of the meat patty. The cheese is usually added to the cooking hamburger patty shortly before serving, which allows the cheese to melt.'),
   
   Product(
        id: 'p5',
        decs: 'No1. in Sales',
        name: 'Chicken Cheese Burger',
        imgUrl: 'https://i.hizliresim.com/fmg455u.png',
        waitTime: '15min',
       cal: '425',
        price: 8,
        score: 4.3,
        about:
            'A cheeseburger is a hamburger topped with cheese. Traditionally, the slice of cheese is placed on top of the meat patty. The cheese is usually added to the cooking hamburger patty shortly before serving, which allows the cheese to melt.'),
   
   
  ];

 

final String authToken;
  final String userId;

  Products(this.authToken, this.userId, this._items);

  List<Product> get items {
   
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((ProductItem) => ProductItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }



 Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url =
        'https://flutter-update.firebaseio.com/products.json?auth=$authToken&$filterString';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      url =
          'https://flutter-update.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(Uri.parse(url));
      final favoriteData = json.decode(favoriteResponse.body);
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          name: prodData['name'],
          decs: prodData['decs'],
          price: prodData['price'],
          isFavorite: prodData['isFavorite'],
          imgUrl: prodData['imgUrl'],
          waitTime: prodData['waitTime'],
          cal: prodData['cal'],
          score: prodData['score'],
         
          about: prodData['about'],
          
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
