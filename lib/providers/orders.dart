import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:resorapp/providers/product.dart';
import 'cart.dart';
import 'auth.dart';
import 'dart:developer' as dev;

String baseUrl = "https://resor.herokuapp.com";

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  final String tableNo;
  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
    @required this.tableNo,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String authToken;
  final String userId;
  Orders(this.authToken, this.userId, this._orders);

  List<OrderItem> get orders {
    fetchAndSetOrders();
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    var header = {
      "Content-Type": "application/json",
      "x-access-token": authToken,
    };
    final url = baseUrl + '/api/users/$userId/orders';
    final response = await http.get(Uri.parse(url), headers: header);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body);
    if (extractedData == null) {
      return;
    }

    extractedData.forEach((orderData) {
      for (var item in extractedData) {
        loadedOrders.add(OrderItem(
          id: item['_id'],
          tableNo: item['tableNo'],
          amount: item['totalPrice'].toDouble(),
          dateTime: DateTime.parse(item['createdAt']),
          products: (item['items'] as List<dynamic>)
              .map(
                (item) => CartItem(
                  quantity: item['quantity'],
                  food: Product(
                      id: item['food']["_id"],
                      decs: "",
                      name: item['food']["title"],
                      imgUrl: item['food']["imageUrl"],
                      waitTime: item['food']["waitTime"].toString(),
                      score: item['food']["description"].toString(),
                      cal: item['food']["calories"].toString(),
                      price: item['food']["price"].toDouble(),
                      about: item['food']["about"]),
                ),
              )
              .toList(),
        ));
      }
    });

    _orders = loadedOrders.reversed.toList();
    dev.log(
        "${_orders[0].products[0].food.name} + ${_orders[0].products[0].food.price.toString()}  ${_orders[0].products[0].quantity.toString()}");
    notifyListeners();
  }

  Future<void> addOrder(
      List<CartItem> cartProducts, double total, int tableNumber) async {
    var header = {
      "Content-Type": "application/json",
      "x-access-token": authToken,
    };
    final url = baseUrl + '/api/users/$userId/orders';
    dev.log(authToken);
    String jsonList = cartProducts
        .map((cp) => {
              '"foodId"': '"${cp.id}"',
              '"quantity"': '"${cp.quantity}"',
              '"tableNo"': '"$tableNumber"',
            })
        .toString();

    jsonList = replaceCharAt(jsonList, 0, '[');
    jsonList = replaceCharAt(jsonList, jsonList.length - 1, ']');
    dev.log(jsonList);
    final timestamp = DateTime.now();
    final response =
        await http.post(Uri.parse(url), headers: header, body: jsonList);
    dev.log(response.statusCode.toString());
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: timestamp,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }

  String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) +
        newChar +
        oldString.substring(index + 1);
  }
}
