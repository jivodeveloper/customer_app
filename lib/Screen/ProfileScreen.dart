import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }

}

class ProfileScreenState extends State<ProfileScreen>{

  final List<String> iconlist = [
    'Icons.arrow_forward_ios',
    'Icons.arrow_forward_ios',
    'Icons.arrow_forward_ios',
    'Icons.arrow_forward_ios',
    'Icons.arrow_forward_ios',
  ];

  final List<String> listname = [
    'Wallet',
    'Wishlist',
    'Orders',
    'About us',
    'Rate Us',
    'Customer Support'
  ];

  @override
  Widget build(BuildContext context) {
     return Scaffold(
        body: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, indexx) {
                return Column(
                  children: [

                    Container(
                      color: Colors.grey,
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: [

                          Icon(Icons.arrow_forward_ios,color: Color(0xFF063A06)),
                          Text(listname[indexx]),
                          Icon(Icons.arrow_forward_ios,color: Color(0xFF063A06))

                        ],
                      ),
                    )

                  ],
                );
            }
     ),
  );

  }

}