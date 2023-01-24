import 'dart:convert';
import 'package:customer_app/Screen/RegisterScreen.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import '../Classes/Common.dart';
import 'package:customer_app/Model/Userdata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'HomeScreen.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

class LoginScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }

}

class LoginScreenState extends State<LoginScreen>{

    bool is_Hidden = true;
    final _formKey = GlobalKey<FormState>();
    TextEditingController mobile = TextEditingController();

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          body: SingleChildScrollView(
            child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: <Widget>[

                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                              'assets/Images/logo.png', height: 150)
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: Column(
                        children: const [

                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Log in or sign up ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF063A06),
                                  fontSize: 20,
                                ),
                             )
                          ),

                        ],
                      ),

                    ),

                    Form(
                      key: _formKey,
                      child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10,top: 10,right: 10,bottom: 10),
                              child: Material(
                                 elevation: 10,
                                 child: Container(
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10),
                                     border: Border.all(color: Color(0xFFEFE4E4),
                                    ),
                                   ),
                                   child:TextFormField(
                                     keyboardType: TextInputType.number,
                                     controller: mobile,
                                     decoration: const InputDecoration(
                                         border: InputBorder.none,
                                         prefixIcon: Icon(Icons.lock,
                                             color: Color(0xFF063A06)
                                         ),
                                         hintText: 'Mobile number'
                                     ),
                                   ),
                                 )
                              ),
                            )
                         ]
                      ),
                    ),

                    GestureDetector(

                      onTap: () {
                        submit();
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

                    )

                   ],

                )

            ),
          )
      );
    }

    Future<Userdata?> submit() async {

      //showProgressWithoutMsg(context);
      Userdata? user;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var response = await http.get(Uri.parse("${Common.IP_URL}login?username=${mobile.text}"));

      try {

        if (response.statusCode == 200) {

          user = Userdata.fromJson(json.decode(response.body));

          if(user.getId!=0){

            prefs.setInt(Common.USER_ID, user.getId);
            prefs.setInt(Common.FLAG, user.flag);

            Navigator.of(context).push(SwipeablePageRoute(builder: (BuildContext context) => HomeScreen()));

          }else{

            Navigator.of(context).push(SwipeablePageRoute(builder: (BuildContext context) => RegisterScreen(mobile:mobile.text)));

          }

        }

      }catch (e) {

        Fluttertoast.showToast(msg: "$e", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 16.0);

      }

      return user;

    }

    Future<void> showProgressWithoutMsg(BuildContext context) async {

      await showDialog(context: context, builder: (context) => FutureProgressDialog(getFuture()));

    }

    Future getFuture() {
      return Future(() async {
        await Future.delayed(Duration(seconds: 5));
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
              child: Text('OK'),
            )
          ],
        ),
      );

    }

}
