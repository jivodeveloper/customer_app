import 'package:customer_app/Classes/Common.dart';
import 'package:customer_app/Model/Cart.dart';
import 'package:customer_app/Model/CartModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget{

  String image=  "";
  CartScreen({required this.image});

  @override
  State<StatefulWidget> createState() {
    return CartScreenState();
  }

}

class CartScreenState extends State<CartScreen>{

  var box;
  int quantity=0,price=0;
  late List<Cart> cartitems=[];

  @override
  void initState() {
    super.initState();
    // getcartdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.white,
            leading: const Icon(Icons.arrow_back_ios)),
        body:SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
              children: [

                Expanded(child: SizedBox(
                  height:600,
                  child : Consumer<CartModel>(
                      builder: (context, cart, child) {
                        return SizedBox(
                            height:100,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: 1,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(

                                    margin: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [

                                        Expanded(child: Image.network("${Common.IP}${widget.image}",width: 50, height: 50)),

                                        Expanded(
                                          flex:1,
                                          child:Text("${cart.items[index].p_name}",style: TextStyle(fontSize: 16),),

                                        ),

                                        Expanded(
                                          flex: 1,
                                          child:Text("${cart.items[index].price}"),
                                        ),

                                        Expanded(
                                            flex:1,
                                            child:Container(
                                              margin: EdgeInsets.all(10),
                                              width: 50,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(color: const Color(0xFF063A06),),
                                              ),
                                              child:Row(

                                                children: [

                                                  Expanded(
                                                      flex:1,
                                                      child:Container(
                                                          color: const Color(0xFF063A06),
                                                          child: const Center(
                                                            child: Text(
                                                                "-",style: TextStyle(color:Colors.white,fontSize: 28)
                                                            ),
                                                          )
                                                      )

                                                  ),

                                                  Expanded(
                                                      flex:1,
                                                      child: Container(
                                                          color: Color(0xFF063A06),
                                                          child: Center(child:Text("${cart.items[index].qty}",style: TextStyle(color:Colors.white,fontSize: 16)))
                                                      )
                                                  ),

                                                  Expanded(
                                                      flex:1,
                                                      child:Container(
                                                          color: const Color(0xFF063A06),
                                                          child: const Center(
                                                            child: Text(
                                                                "+",style: TextStyle(color:Colors.white,fontSize: 20)
                                                            ),
                                                          )
                                                      )
                                                  ),

                                                ],

                                              ),

                                            )

                                        ),

                                      ],

                                    ),

                                  );
                                }

                            )

                        );

                      }

                    ),

                  ))

              ]

          ),

        )

    );
  }

  Future<void> getcartdata() async {

    var cart = context.watch<CartModel>();

    // try{
    //
    //   box = await Hive.box<Cart>('Items');
    //
    //   for(var i = 0; i < box.length; i++) {
    //
    //     setState(() {
    //
    //       cartitems.add(box.getAt(i));
    //
    //     });
    //
    //   }
    //
    // }catch(e){
    //
    //   print("Cart Exception $e");
    //
    // }

  }

}