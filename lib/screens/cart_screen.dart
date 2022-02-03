import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:resorapp/constant/constant.dart';
import 'package:resorapp/screens/product_overview_screen.dart';
import 'package:resorapp/screens/qrscan.dart';
import 'package:resorapp/widgets/customAppBar.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      backgroundColor: kBackGround,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Your Cart'),
        actions: [
          // IconButton(
          //     onPressed: () => Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => ScanQR())),
          //     icon: Icon(
          //       Icons.photo_camera_rounded,
          //       size: 30,
          //     ))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, i) => CartItem(
                cart.items.values.toList()[i].id,
                cart.items.keys.toList()[i], //productId
                cart.items.values.toList()[i].price,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].name),
          )),
          Card(
            child: Padding(
              padding: EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total:',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Chip(
                      label: Text(
                        '\$${cart.totalAmount}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: kPrimaryColor),
                  Spacer(),
                  ElevatedButton(
                    child: Text('ORDER'),
                    style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                          cart.items.values.toList(), cart.totalAmount);
                      cart.clear();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
