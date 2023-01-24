import 'dart:async';
import 'package:customer_app/Screen/HomeScreen.dart';
import 'package:customer_app/Screen/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Classes/Common.dart';

class SplashScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }

}

class SplashScreenState extends State<SplashScreen>  with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    checkisalreadyloggedin();
  }

  void checkisalreadyloggedin() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getInt(Common.USER_ID);

    if(user_id!=0 && user_id!=null){

      Timer(
        Duration(seconds: 3),
            () async {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
        },
      );

    }else{

      Timer(
        Duration(seconds: 3),
            () async {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
        },
      );

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

          child:ScaleTransition(
            scale: _animation,
            child: AnimatedOpacity(
              opacity: _visible?1.0:0.0,
              duration: Duration(milliseconds: 500),
              child: Container(
                child: Image.asset('assets/Images/jivo_logo.png', height: 250, width: 250),
              ),
            ),
          )

      ),
    );
  }

}