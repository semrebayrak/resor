import 'package:flutter/material.dart';
import 'package:resorapp/widgets/product_item.dart';

import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
        id: 'p1',
        decs: 'No1. in Sales',
        name: 'Chicken Cheese Burger',
        imgUrl: 'https://i.hizliresim.com/fmg455u.png',
        waitTime: '15min',
        score: 4.8,
        cal: '425',
        price: 8,
        quantity: 1,
        about:
            'A cheeseburger is a hamburger topped with cheese. heeseburger is a hamburger topped with cheese. Traditionally, the slice of cheese is placed on top of the meat paheeseburger is a hamburger topped with cheese.'),
    Product(
        id: 'p2',
        decs: 'No1. in Sales',
        name: 'Fries',
        imgUrl: 'https://i.hizliresim.com/fmg455u.png',
        waitTime: '15min',
        score: 4.8,
        cal: '425',
        price: 8,
        quantity: 1,
        about:
            'A 2cheeseburger is a hamburger topped with cheese.ssssssssssssssssssssssssssss Traditionally, the slice of cheese is placed on top of the meat patty. The cheese is usually added to the cooking hamburger patty shortly before serving, which allows the cheese to melt.'),
    Product(
        id: 'p3',
        decs: 'No1. in Sales',
        name: 'Spride',
        imgUrl: 'https://i.hizliresim.com/fmg455u.png',
        waitTime: '15min',
        score: 4.8,
        cal: '425',
        price: 8,
        quantity: 1,
        about:
            'A 3cheeseburger is a hamburger topped with cheese. Traditionally, the slice of cheese is placed on top of the meat patty. The cheese is usually added to the cooking hamburger patty shortly before serving, which allows the cheese to melt.'),
    Product(
        id: 'p7',
        decs: 'No1. in Sales',
        name: 'Chicken Cheese Burger',
        imgUrl: 'https://i.hizliresim.com/fmg455u.png',
        waitTime: '15min',
        score: 4.8,
        cal: '425',
        price: 8,
        quantity: 1,
        about:
            'A 4cheeseburger is a hamburger topped with cheese. Traditionally, the slice of cheese is placed on top of the meat patty. The cheese is usually added to the cooking hamburger patty shortly before serving, which allows the cheese to melt.'),
    Product(
        id: 'p4',
        decs: 'No1. in Sales',
        name: 'Chicken Cheese Burger',
        imgUrl: 'https://i.hizliresim.com/fmg455u.png',
        waitTime: '15min',
        score: 4.8,
        cal: '425',
        price: 8,
        quantity: 1,
        about:
            'A cheeseburger is a hamburger topped with cheese. Traditionally, the slice of cheese is placed on top of the meat patty. The cheese is usually added to the cooking hamburger patty shortly before serving, which allows the cheese to melt.'),
    Product(
        id: 'p5',
        decs: 'No1. in Sales',
        name: 'Chicken Cheese Burger',
        imgUrl: 'https://i.hizliresim.com/fmg455u.png',
        waitTime: '15min',
        score: 4.8,
        cal: '425',
        price: 8,
        quantity: 1,
        about:
            'A cheeseburger is a hamburger topped with cheese. Traditionally, the slice of cheese is placed on top of the meat patty. The cheese is usually added to the cooking hamburger patty shortly before serving, which allows the cheese to melt.'),
    Product(
        id: 'p6',
        decs: 'No1. in Sales',
        name: 'Chicken Cheese Burger',
        imgUrl: 'https://i.hizliresim.com/fmg455u.png',
        waitTime: '15min',
        score: 4.8,
        cal: '425',
        price: 8,
        quantity: 1,
        about:
            'A cheeseburger is a hamburger topped with cheese. Traditionally, the slice of cheese is placed on top of the meat patty. The cheese is usually added to the cooking hamburger patty shortly before serving, which allows the cheese to melt.'),
  ];

  // var _showFavoritesOnly = false;

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
}
