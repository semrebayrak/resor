import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resorapp/constant/constant.dart';
import 'package:resorapp/screens/qrscan.dart';
import 'package:resorapp/widgets/customAppBar.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  
 

  @override
  Widget build(BuildContext context) {
    
   
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Your Orders'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios))
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, i) =>
            OrderItem(orderData.orders[i],),
        itemCount: orderData.orders.length,
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
