import 'package:customer_app/Screen/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Model/Cart.dart';

void main() async {

  await Hive.initFlutter();
  Hive.registerAdapter(CartAdapter());
  // await Hive.openBox<Cart>('cart');
  //runApp(ProviderScope(child: MyApp()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
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
    );
  }

}

