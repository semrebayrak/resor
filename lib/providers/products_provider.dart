import 'package:flutter/material.dart';
import 'package:resorapp/widgets/product_item.dart';

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

  // var _showFavoritesOnly = false;

  final String authToken;
  Products(this.authToken, this._items);

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((ProductItem) => ProductItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((ProductItem) => ProductItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  Future<void> fetchAndSetProducts() async {
    final url = 'https://flutter-update.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
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
