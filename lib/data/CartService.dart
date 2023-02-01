
import 'package:customer_app/Model/Cart.dart';
import 'package:hive_flutter/adapters.dart';

class CartService {

  static Future<void> add(Cart cart)async{
    var box = Hive.box<Cart>('cart');
    box.add(cart);
  }

  Future<void> remove(Cart cart)async{
    var box = Hive.box<Cart>('cart');
    box.delete(cart.key);
  }

  static Future<List<Cart>> fetch()async{
    var box = Hive.box<Cart>('cart');
    return box.values.toList();
  }

  Future<void> updateQuantity(Cart cart, int quantity)async{
    var box = Hive.box<Cart>('cart');
    cart.quantity = quantity;
    box.put(cart.key, cart);
  }

  Future<void> updatePrice(Cart cart, double price)async{
    var box = Hive.box<Cart>('cart');
    cart.price = price;
    box.put(cart.key, cart);
  }

  Future<void> clear()async{
    var box = Hive.box<Cart>('cart');
    box.clear();
  }

  Future<void> dispose()async{
    await Hive.close();
  }

}