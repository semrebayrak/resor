import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resorapp/screens/product_overview_screen.dart';

import './screens/cart_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products_provider.dart';
import 'providers/cart.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import 'screens/auth_screen.dart';
import './providers/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
            update: (ctx, auth, previousProduct) => Products(auth.token,
                previousProduct == null ? [] : previousProduct.items),
            create: (ctx) => Products(),
          ),
          ChangeNotifierProvider(create: (context) => Cart()),
          ChangeNotifierProvider(
            create: (context) => Orders(),
          )
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'ResorApp',
            theme: ThemeData(
                primaryColor: Colors.blue, accentColor: Colors.deepOrange),
            home: auth.isAuth ? ProductOverviewScreen() : AuthScreen(),
            routes: {
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
            },
          ),
        ));
  }
}
