import 'dart:developer';
import 'package:customer_app/Model/CartModel.dart';
import 'package:customer_app/Screen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:customer_app/Model/Cart.dart';

void main() async {

  await Hive.initFlutter();
  Hive.registerAdapter(CartAdapter());
  await Hive.openBox('Items');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
        create: (context) => CartModel(),
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Provider Demo',
        theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MaterialApp(

          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: HomeScreen()

      )
      ),
    );
  }

}

