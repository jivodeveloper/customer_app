import 'package:customer_app/Model/CartModel.dart';
import 'package:customer_app/Model/CartProvider.dart';
import 'package:customer_app/Screen/CartScreen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../Classes/Common.dart';
import '../Model/Cart.dart';

class FeaturedProductdetails extends StatefulWidget{

  String product_name="",quantity="",price="",product_image="",p_id="";
  FeaturedProductdetails({required this.product_image,required this.product_name,required this.p_id,required this.quantity,required this.price});

  @override
  State<StatefulWidget> createState() {
    return FeaturedProductstate();
  }

}

class FeaturedProductstate extends State<FeaturedProductdetails>{

  bool cart_layout= false,add_button=true,incre_decr=false;
  int quantity=0,price=0;
  int total_amount=0, total_quantity=0;
  List<Map<String, dynamic>> _items = [];
  late final box;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(

        appBar: AppBar(backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon:Icon(Icons.arrow_back,color: Color(0xFF063A06)),
            )
        ),

        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            children: [

              Expanded(
                flex: 3,
                child: Column(
                  children: [

                    Image.network("${Common.IP}${widget.product_image}", height: 350),

                    Padding(
                      padding:const EdgeInsets.all(10),
                      child:Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(widget.product_name)
                      ),
                    ),

                    Padding(
                        padding: EdgeInsets.only(left: 10,top: 5,right: 10),
                        child:Align(
                          alignment: Alignment.centerLeft,
                          child: Text(widget.quantity,style:const TextStyle(color: Colors.grey),),
                        )
                    ),

                    Padding(
                        padding:  const EdgeInsets.only(left: 10,top: 0,right: 10),
                        child:Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [

                                Expanded(
                                  flex: 2,
                                    child: Text("\u{20B9} ${widget.price}")
                                ),

                                Expanded(
                                    flex:1,
                                    child: Container(
                                        child: quantity==0?GestureDetector(
                                            onTap: (){

                                             savetocart();
                                            //getcartdata();

                                              setState((){

                                                cart_layout = true;
                                                add_button = false;
                                                incre_decr = true;

                                              });

                                            },
                                            child:Visibility(
                                                visible:add_button,
                                                child:Container(
                                                  margin: const EdgeInsets.all(10),
                                                  width: 85,
                                                  height: 45,
                                                  decoration:  const BoxDecoration(
                                                    color: Color(0xFF063A06),
                                                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                  ),
                                                  child:Center(
                                                    child: Text(
                                                        "ADD", style: TextStyle(color: Colors.white)
                                                    ),
                                                  )
                                                )
                                            )
                                        ): Visibility(
                                            visible: incre_decr,
                                            child: Container(
                                              color: Colors.white,
                                              child: Row(
                                                children: [

                                                  Expanded(
                                                      flex:1,
                                                      child:Center(
                                                          child: GestureDetector(

                                                            onTap: () {
                                                              //decrement();
                                                            },

                                                            child: Text(
                                                                "-",style: TextStyle(color:Colors.green,fontSize: 35)
                                                            ),
                                                          )
                                                      )
                                                  ),

                                                  Expanded(
                                                    flex:1,
                                                    child: Center(
                                                        child: Text(
                                                            " $quantity ",style: TextStyle(color:Colors.black,fontSize: 15)
                                                        )
                                                    ),
                                                  ),

                                                  Expanded(
                                                    flex:1,
                                                    child:Center(
                                                        child: GestureDetector(

                                                          onTap: (){
                                                           //  increment();
                                                          },

                                                          child:Text(
                                                              "+",style: TextStyle(color:Colors.green,fontSize: 25)
                                                          ),

                                                        )
                                                    ),
                                                  )

                                                ],
                                              ),
                                            )
                                        )
                                     ),
                                ),

                              ],
                            )
                        )
                     ),

                  ],
                ),
              ),

              Expanded(
                flex: 1,
                child:Align(
                  alignment: Alignment.bottomCenter,
                  child: Visibility(
                      visible: cart_layout,
                      child:  Container(
                          margin: EdgeInsets.all(15),
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Color(0xFF063A06),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Row(
                            children: [

                              Expanded(
                                  flex: 2,
                                  child:Padding(
                                    padding: EdgeInsets.all(10),
                                    child:  Row(
                                      children:  [

                                        Text("$quantity Item | ",style: TextStyle(color: Colors.white)),
                                        Text("\u{20B9} $total_amount",style: TextStyle(color: Colors.white))

                                      ],
                                    ),
                                  )
                              ),

                              Expanded(
                                  flex: 1,
                                  child:Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(image:widget.product_image)));
                                        },
                                        child: Text("Go to Cart",style: TextStyle(color: Colors.white)),
                                      )
                                    ),
                                  )
                              )

                           ],
                        )
                      )
                    )
                 ),
               )

            ],
          ),
      ),

    );
  }

  // void increment() async{
  //
  //   total_quantity = quantity;
  //
  //   setState((){
  //
  //     total_quantity = total_quantity+1;
  //     total_amount = total_amount+price;
  //     quantity = total_quantity;
  //
  //   });
  //
  //   box = await Hive.openBox<Cart>('Items');
  //
  //   Cart cart = Cart();
  //   cart.qty = total_quantity;
  //   box.putAt('qty',cart);
  //
  //   // Cart cart1 = Cart();
  //   // cart.price = total_amount;
  //   // await box.put('price',cart1);
  //
  // }
  //
  // void decrement() async{
  //
  //   setState((){
  //
  //     total_quantity = total_quantity-1;
  //     total_amount = total_amount-price;
  //
  //     if(total_quantity>0){
  //       quantity = total_quantity;
  //     }else{
  //
  //       setState((){
  //
  //         quantity =0;
  //         cart_layout = false;
  //         incre_decr = false;
  //         add_button = true;
  //
  //       });
  //
  //     }
  //
  //   });
  //
  //   box = await Hive.openBox<Cart>('Items');
  //
  //   Cart cart = Cart();
  //   cart.qty = total_quantity;
  //   await box.put('qty',cart);
  //
  // }

  Future<void> savetocart() async {

    /*save in provider*/

    // CartProvider cartProvider = CartProvider();
    //
    // cartProvider.p_id = int.parse(widget.p_id);
    // cartProvider.p_name = widget.product_name;
    // cartProvider.qty = 1;
    // cartProvider.price =int.parse(widget.price);
    // cartProvider.image = widget.product_image;
    //
    // quantity = 1;
    //
    // var cart = context.read<CartModel>();
    // cart.add(cartProvider);

    // try {
    //
    //   box = await Hive.openBox<Cart>('Items');
    //   Cart cart = Cart(p_id:int.parse(widget.p_id) ,p_name: widget.product_name,qty:1,price:int.parse(widget.price));
    //   box.add(cart);
    //
    //   quantity = 1;
    //
    //   setState((){
    //
    //     total_amount = int.parse(widget.price);
    //
    //   });
    //
    // }catch(e){
    //
    //   print("Exception $e");
    //
    // }

    _createItem({"p_id":widget.p_id,
      "p_name":widget.product_name,
      "qty":widget.quantity,
      "price":widget.price});

  }

  Future<void> _createItem(Map<String, dynamic> newItem) async {

    box = await Hive.box('Items');
    // Cart cart = Cart(p_id:int.parse(widget.p_id),
     //     p_name:widget.product_name,
     //     qty:1,
     //     price:int.parse(widget.price));

    box.add(newItem);
    _refreshItems();

  }

  void _refreshItems() {

    final data = box.keys.map((key) {
    final value = box.get(key);
    return {"p_id": value?.p_id,"p_name": value?.p_name, "qty": value?.qty,"price": value?.price};
    //return {"p_id": value.p_id,"p_name": value.p_name, "qty": value.qty,"price": value.price};
    }).toList();

    setState(() {
      _items = data.reversed.toList();
    });

    print("items${_items.length}");

  }

  // Future<void> getcartdata() async {
  //
  //   try{
  //
  //     box = await Hive.box<Cart>('Items');
  //
  //     for(var i = 0; i < box.length; i++) {
  //
  //         setState(() {
  //
  //           quantity = box.getAt(i).qty;
  //           price = box.getAt(i).price;
  //
  //         });
  //
  //     }
  //
  //   }catch(e){
  //
  //     print("Cart Exception $e");
  //
  //   }
  //
  // }

}