import 'dart:convert';
import 'package:customer_app/Model/Banners.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:customer_app/Screen/FeaturedProductdetails.dart';
import 'package:customer_app/Screen/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import '../Classes/Common.dart';

class HomeScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }

}

class HomeScreenState extends State<HomeScreen>{

  List<String> bannerlist = [];
  List<String> categorylist = [];
  List<String> categoryid = [];
  List<String> categoryname = [];

  final List<String> oldprice=[
    '200',
    '300',
    '350',
  ];

  final List<String> fe_pro_price=[
    '150',
    '240',
    '300',
  ];

  final List<String> featuredproduct=[
    'Kachi Ghani musturd Oil 3L',
    'Musturd Oil 5L +Extra Light Olive Oil 5L',
    'Jivo Stainless Steel Solid,Chappati box,Casserole Thermoware -Pack of 2',
  ];

  final List<String> featuredproductimage=[
    'assets/Images/lifybox.jpg',
    'assets/Images/choco.jpg',
    'assets/Images/chia_seeds.jpg',
  ];

  Position? _currentPosition;
  String _currentAddress="",state="",zone="",area="";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _handleLocationPermission();
    _getCurrentPosition();
    getbanner();
    getcategory();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(
              height: 90,
              child: Row(
                children:  [

                  Expanded(
                      flex:5,
                      child: Padding(
                        padding: const EdgeInsets.only(left:10,top:40,bottom:30),
                        child: Text(_currentAddress,style: const TextStyle(color: Colors.black,fontSize: 16)),
                      )
                  ),

                  Expanded(
                      flex:1,
                      child: Padding(
                        padding: const EdgeInsets.only(top:40),
                        child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                            },
                            child: const Align(
                              alignment: Alignment.topRight,
                              child: Image(image: AssetImage("assets/Images/user_color.png"),
                                  width: 30,
                                  height: 30),
                            )
                        ),
                     )
                  ),

                ],
              ),
            ),

            Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFD6E3C5),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                margin: const EdgeInsets.all(10),
                child:const TextField(
                    style: TextStyle(height: 1),
                    decoration: InputDecoration(
                        labelText: "Search",
                        hintText:"Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)
                            )
                        )
                    )
                )
            ),

            CarouselSlider(
                options: CarouselOptions(
                viewportFraction: 0.8,
                autoPlayAnimationDuration: const Duration(milliseconds: 100),
                autoPlay: true,
                enlargeCenterPage: true,),
                items: bannerlist.map((item) => Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage("${Common.IP}$item"),
                    fit: BoxFit.cover,
                  ),
                ),
               ),
              ).toList(),
            ),

            Column(
              children: [

                Row(
                  children: const [

                    Expanded(
                    flex: 1,
                    child:Align(
                        alignment: Alignment.topLeft,
                        child: Padding(padding: EdgeInsets.only(left: 10,top:15,right: 10,bottom:10 ),
                            child:Text("Featured Product", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,fontFamily: 'Lato'),
                            )
                        )
                       ),
                    ),

                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.topRight,
                        child:Padding(padding: EdgeInsets.all(10),
                            child:Text("See All",style: TextStyle(fontSize: 16,color: Colors.red,fontFamily: 'Lato'),
                            )
                        )
                      ),
                    )

                  ],
                ),

                Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    height: 220.0,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, indexx) {
                          return GestureDetector(

                            onTap: (){
                              Navigator.of(context).push(SwipeablePageRoute(builder: (BuildContext context) => FeaturedProductdetails(product_image:categorylist[indexx],product_name:categoryname[indexx],p_id:categoryid[indexx],quantity:oldprice[indexx],price:fe_pro_price[indexx])));
                            },

                            child:Column(
                              children: [

                                Card(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                    child:SizedBox(

                                    width: 140,
                                    height: 200,
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        children: [

                                          Expanded(
                                            flex: 5,
                                            child:Image.asset(featuredproductimage[indexx]),
                                          ),

                                          Expanded(
                                              flex: 1,
                                              child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child:Text(featuredproduct[indexx],overflow: TextOverflow.ellipsis)
                                           ),
                                          ),

                                          Row(
                                            children: [

                                              Expanded(
                                                flex: 1,
                                                child:Container(
                                                  margin: EdgeInsets.all(10),
                                                  alignment: Alignment.centerLeft,
                                                  child:Text("\u{20B9} ${oldprice[indexx]}",style: TextStyle(decoration: TextDecoration.lineThrough,fontSize: 15),),
                                                ),
                                              ),

                                              Expanded(
                                                flex: 1,
                                                child:Align(
                                                  alignment: Alignment.bottomCenter,
                                                  child: Container(
                                                    color: Colors.white,
                                                    margin: const EdgeInsets.all(10),
                                                    alignment: Alignment.centerLeft,
                                                    child:Text("\u{20B9} ${fe_pro_price[indexx]}",style: TextStyle(fontSize: 15)),
                                                  ),
                                                )
                                              ),

                                           ],
                                         ),

                                      ]
                                    ),
                                  ),
                                 ),
                                )

                              ],
                            )

                          );
                        }
                    )
                  )

               ]
            ),

            Column(
                children: [

                  Align(
                      alignment: Alignment.topLeft,
                      child:Padding(
                          padding: EdgeInsets.all(10),
                          child:Text("Categories", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,fontFamily: 'Lato'))
                      )
                  ),

                  SizedBox(
                      height: 300.0,
                      child: GridView.builder(
                        padding: const EdgeInsets.only(left: 5,top:5,right: 5),
                        itemCount: categorylist.length,
                        itemBuilder: (context, indexx){
                          return GestureDetector(
                              child:SizedBox(
                                height: 170,
                                child: Column(
                                  children: [

                                    Card(
                                      elevation:3,
                                      child:SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              Image.network("${Common.IP}${categorylist[indexx]}"),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    Text(categoryname[indexx],textAlign: TextAlign.center,),

                                  ],
                                ),
                              )
                          );
                        },
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.9,
                        ),

                      )
                  ),

               ]
            )

           ]
          )
        )
    );
  }

  Future<void> showProgressWithoutMsg(BuildContext context) async {
    await showDialog(context: context, builder: (context) => FutureProgressDialog(getFuture()));
  }

  Future getFuture() {
    return Future(() async {
      await Future.delayed(const Duration(seconds: 5));
      return '';
    });
  }

  void showResultDialog(BuildContext context, String result) {

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(result),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          )
         ],
        ),
    );

  }

  /*banner*/
  Future<void> getbanner() async {

    var response = await http.get(Uri.parse("${Common.IP_URL}Banner"));
    var tagsJson = jsonDecode(response.body)['banners'] as List;

    List<Banners> tags = tagsJson.map((Json) => Banners.fromJson(Json)).toList();

    try {

      if(response.statusCode == 200) {

        for(int i=0;i<tags.length;i++){

          setState((){

            bannerlist.add(tags[i].bannerpath);

          });

        }

      }

    }catch (e) {

      print("banner:$e");

    }

  }

  /*category*/
  Future<void> getcategory() async {

    var response = await http.get(Uri.parse("${Common.IP_URL}CategoryItem"));
    var tagsJson = jsonDecode(response.body)['banners'] as List;

    List<Banners> tags = tagsJson.map((Json) => Banners.fromJson(Json)).toList();

    try {

      if(response.statusCode == 200) {

        for(int i=0;i<tags.length;i++){

          setState((){

            categoryid.add(tags[i].id.toString());
            categorylist.add(tags[i].bannerpath);
            categoryname.add(tags[i].banner);

          }

        );

       }

      }

   }catch (e) {

    print("banner:$e");

   }

  }

  /*handle location*/
  Future<bool> _handleLocationPermission() async {

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable the services')));
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }

    return true;

  }

  Future<void> _getCurrentPosition() async {

    final hasPermission = await _handleLocationPermission();

    if (!hasPermission)
      return;

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {

      setState(() =>
      _currentPosition = position
      );
      _getAddressFromLatLng(_currentPosition!);

    }).catchError((e) {

      print(e);

    });

  }

  /*get address lat n lng*/
  Future<void> _getAddressFromLatLng(Position position) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await placemarkFromCoordinates(_currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {

      Placemark place = placemarks[0];

      setState(() {

        state =  place.locality!;
        area = place.subLocality!;

        _currentAddress = '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}';
        prefs.setString(Common.ADDRESS, _currentAddress);

      });

    }).catchError((e) {

      print("Exception $e");

    });

  }

}











