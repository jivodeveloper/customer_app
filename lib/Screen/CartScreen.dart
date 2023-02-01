import 'package:customer_app/Classes/Common.dart';
import 'package:customer_app/Model/Cart.dart';
import 'package:customer_app/cart/cart_list.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../data/CartService.dart';

class CartScreen extends StatefulWidget{

  String image=  "";
  CartScreen({required this.image});

  @override
  State<StatefulWidget> createState() {
    return CartScreenState();
  }

}

class CartScreenState extends State<CartScreen>{

  late final Box box;
  int quantity=0,price=0;
  late List<Cart> cartitems=[];

  @override
  void initState() {
    super.initState();
    // getcartdata();
    getcartdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Text("Hello"),
        )
        // body:CartWidget(cartBuilder: (controller) {
        //   return Column(
        //     children: [
        //       Expanded(
        //         child: ListView.builder(
        //           itemCount: 1,
        //           itemBuilder: (context, index) {
        //             final cartItem = controller.cartList[index];
        //             return ListTile(
        //               title: Text("Item name${cartItem.name}"),
        //               subtitle: Text(controller
        //                   .getPriceForItem(cartItem, updatePrice: true)
        //                   .toString()),
        //               trailing: Row(
        //                 mainAxisSize: MainAxisSize.min,
        //                 children: [
        //                   IconButton(
        //                     onPressed: () {
        //                       controller.incrementItemQuantity(cartItem);
        //                     },
        //                     icon: const Icon(Icons.add),
        //                   ),
        //                   Text(cartItem.quantity.toString()),
        //                   IconButton(
        //                     onPressed: () {
        //                       controller.decrementItemQuantity(cartItem);
        //                     },
        //                     icon: const Icon(Icons.remove),
        //                   ),
        //                 ],
        //               ),
        //               leading: IconButton(
        //                 icon: const Icon(Icons.remove),
        //                 onPressed: () {
        //                   controller.removeItem(cartItem);
        //                 },
        //               ),
        //             );
        //           },
        //         ),
        //       ),
        //       // ----------------- Total Price in Cart ----------------- //
        //       Text("Total Price : ${controller.getTotalPrice()}"),
        //     ],
        //   );
        // }
      //)
    );

  }

  void getcartdata(){

    var list = CartService.fetch() as List<Cart>;
    print("list size ${list.length}");

  }

  // Future<void> getcartdata() async {
  //
  //   var cart = context.watch<CartModel>();
  //
  //   // try{
  //   //
  //   //   box = await Hive.box<Cart>('Items');
  //   //
  //   //   for(var i = 0; i < box.length; i++) {
  //   //
  //   //     setState(() {
  //   //
  //   //       cartitems.add(box.getAt(i));
  //   //
  //   //     });
  //   //
  //   //   }
  //   //
  //   // }catch(e){
  //   //
  //   //   print("Cart Exception $e");
  //   //
  //   // }
  //
  // }

}