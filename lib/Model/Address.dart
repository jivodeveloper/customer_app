import 'package:flutter/material.dart';

class Address{

      var lat;
      var long;

      Address({this.lat,this.long});

      factory Address.fromJson(Map<String, dynamic> json) {
            return Address(
                  lat: json['lat'],
            );
      }

      Map<String, dynamic> toJson() {

            final Map<String, dynamic> data = new Map<String, dynamic>();
            data['lat'] = this.lat;
            data['long'] = this.long;
            return data;

      }

}