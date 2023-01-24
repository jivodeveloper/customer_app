import 'dart:convert';
import 'package:customer_app/Screen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import '../Classes/Common.dart';
import 'package:http/http.dart' as http;
import '../Model/Userdata.dart';

class RegisterScreen extends StatefulWidget{

  String mobile;
  RegisterScreen({required this.mobile});

  @override
  State<StatefulWidget> createState() {
    return RegisterScreenState();
  }

}

class RegisterScreenState extends State<RegisterScreen>{

  Position? _currentPosition;
  String _currentAddress="",state="",zone="",area="",userid="";
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  void initState() {
    super.initState();
   _handleLocationPermission();
   _getCurrentPosition();
    // getstate();
    // getzone();
    // getarea();
  }

  // Future<void> getstate() async {
  //   var response = await http.get(Uri.parse("${Common.IP_URL}State.dart"));
  //   try {
  //
  //     if (response.statusCode == 200) {
  //
  //       user = Userdata.fromJson(json.decode(response.body));
  //
  //       if(user.getId!=0){
  //
  //         userid = user.getId;
  //         prefs.setInt(Common.USER_ID, user.getId);
  //         savelocation();
  //
  //       }else{
  //
  //         Fluttertoast.showToast(msg: "Something went wrong!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 16.0);
  //
  //       }
  //
  //     }else{
  //
  //       Fluttertoast.showToast(msg: "Something went wrong!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 16.0);
  //
  //     }
  //
  //   }catch (e) {
  //
  //     Fluttertoast.showToast(msg: "$e", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 16.0);
  //
  //   }
  // }

  // Future<void> getzone() async {
  //   var response = await http.get(Uri.parse("${Common.IP_URL}Zone"));
  //   try {
  //
  //     if (response.statusCode == 200) {
  //
  //       user = Userdata.fromJson(json.decode(response.body));
  //
  //       if(user.getId!=0){
  //
  //         userid = user.getId;
  //         prefs.setInt(Common.USER_ID, user.getId);
  //         savelocation();
  //
  //       }else{
  //
  //         Fluttertoast.showToast(msg: "Something went wrong!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 16.0);
  //
  //       }
  //
  //     }else{
  //
  //       Fluttertoast.showToast(msg: "Something went wrong!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 16.0);
  //
  //     }
  //
  //   }catch (e) {
  //
  //     Fluttertoast.showToast(msg: "$e", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 16.0);
  //
  //   }
  // }

  // Future<void> getarea() async {
  //   var response = await http.get(Uri.parse("${Common.IP_URL}Area"));
  //   try {
  //
  //     if (response.statusCode == 200) {
  //
  //       user = Userdata.fromJson(json.decode(response.body));
  //
  //       if(user.getId!=0){
  //
  //         userid = user.getId;
  //         prefs.setInt(Common.USER_ID, user.getId);
  //         savelocation();
  //
  //       }else{
  //
  //         Fluttertoast.showToast(msg: "Something went wrong!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 16.0);
  //
  //       }
  //
  //     }else{
  //
  //       Fluttertoast.showToast(msg: "Something went wrong!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 16.0);
  //
  //     }
  //
  //   }catch (e) {
  //
  //     Fluttertoast.showToast(msg: "$e", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 16.0);
  //
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top:20),
        child: Form(
          key: _formKey,
          child: Column(
              children: [

                Material(
                  elevation: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xFFEFE4E4),
                      ),
                    ),
                    child: TextFormField(
                      controller: name,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock,
                            color: Color(0xFF063A06),),
                          hintText: 'Name'
                      ),
                    ),
                  ),
                ),

                Material(
                  elevation: 10,
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xFFEFE4E4))),
                    child:TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock,
                            color: Color(0xFF063A06)
                          ),
                          hintText: 'Email'
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    register();
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    width: double.infinity,
                    height: 55,
                    decoration: const BoxDecoration(
                      color: Color(0xFF063A06),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    child: const Center(
                      child: Text(
                        "CONTINUE",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),

              ]
          ),
        ),
      ),
    );
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

  /*register*/
  void register() async{

    var response = await http.post(Uri.parse("${Common.IP_URL}EmployeeProfile?CustAPimobile=${widget.mobile}&name=${name.text}&Address=$_currentAddress&State_id=$state&Zone_id=1&Area_id=$zone&CustAPiEmail=${email.text}"));
    Userdata? user;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {

      if (response.statusCode == 200) {

        user = Userdata.fromJson(json.decode(response.body));

        if(user.getId!=0){

          userid = user.getId;
          prefs.setInt(Common.USER_ID, user.getId);
          savelocation();

        }else{

          Fluttertoast.showToast(msg: "Something went wrong!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 16.0);

        }

      }else{

        Fluttertoast.showToast(msg: "Something went wrong!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 16.0);

      }

    }catch (e) {

      Fluttertoast.showToast(msg: "$e", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 16.0);

    }

  }

  Future<Userdata?> savelocation() async {

    Userdata? user;
    var response = await http.get(Uri.parse("${Common.IP_URL}Location?Id=$userid&Address=$_currentAddress&type=Current"));

    try {

      if (response.statusCode == 200) {

        user = Userdata.fromJson(json.decode(response.body));

        if(user.result==1){

          Navigator.of(context).push(SwipeablePageRoute(builder: (BuildContext context) => HomeScreen()));

        }else{

          Navigator.of(context).push(SwipeablePageRoute(builder: (BuildContext context) => RegisterScreen(mobile:widget.mobile)));

        }

      }

    }catch (e) {

      Fluttertoast.showToast(msg: "$e", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 16.0);

    }

    return user;

  }

  /*get current location*/
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