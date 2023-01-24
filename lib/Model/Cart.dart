import 'package:hive/hive.dart';
part 'Cart.g.dart';

@HiveType(typeId: 0)
class Cart{

  @HiveField(0)
  int? p_id;

  @HiveField(1)
  String? p_name;

  @HiveField(2)
  int? qty;

  @HiveField(3)
  int? price;

  Cart({
  this.p_id,
  this.p_name,
  this.qty,
  this.price});

}