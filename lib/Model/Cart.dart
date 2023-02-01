import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
part 'Cart.g.dart';

@HiveType(typeId: 0)
class Cart extends HiveObject {

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  double price;
  @HiveField(3)
  int quantity;
  @HiveField(4)
  final Map<String, dynamic> additionalData;

  Cart({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
    this.additionalData = const {},
  });

}