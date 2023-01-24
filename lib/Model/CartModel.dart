import 'dart:collection';

import 'package:flutter/cupertino.dart';
import '../Model/CartProvider.dart';

class CartModel extends ChangeNotifier{

  List<CartProvider> _items = [];
  UnmodifiableListView<CartProvider> get items => UnmodifiableListView(_items);

  get size => _items.length;

  void add(CartProvider cartProvider){
    _items.add(cartProvider);
    notifyListeners();
  }

  void remove(CartProvider cartProvider){
    _items.remove(cartProvider);
    notifyListeners();
  }

}