import 'package:customer_app/Model/Cart.dart';
import 'package:customer_app/data/CartService.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';


class CartNotifiers extends ChangeNotifier{

    static final provider = ChangeNotifierProvider((ref) => CartNotifiers());

    final CartService _cartService = CartService();

    List<Cart> _cartList = [];
    List<Cart> get cartList => _cartList;

    CartNotifier() {
      //fetchCart();
    }

    // static initialize() async {
    //     await Hive.initFlutter();
    //     Hive.registerAdapter(CartAdapter());
    //     await Hive.openBox<Cart>('cart');
    // }
    
    // Future<void> addItem(Cart cart) async {
    //     if (_cartList.contains(cart)) {
    //         final int index = _cartList.indexOf(cart);
    //         incrementItemQuantity(_cartList[index]);
    //         getPriceForItem(cart);
    //     } else {
    //         await _cartService.add(cart);
    //         _cartList.add(cart);
    //     }
    //     notifyListeners();
    //
    // }


    //remove item from cart
    Future<void> removeItem(Cart cart) async {
        await _cartService.remove(cart);
        _cartList.remove(cart);
        notifyListeners();
    }
    //
    // Future<void> fetchCart() async {
    //     _cartList = await _cartService.fetch();
    //     notifyListeners();
    // }

    Future<void> clearCart() async {
        await _cartService.clear();
        _cartList = [];
        notifyListeners();
    }
    
    Future<void> incrementItemQuantity(Cart cart) async {
        cart.quantity++;
        await _cartService.updateQuantity(cart, cart.quantity);
        getPriceForItem(cart);
        await _cartService.updatePrice(cart, cart.price);
        notifyListeners();
    }

    Future<void> decrementItemQuantity(Cart cart, {bool deleteOption = false,Function? actionAfterDelete, Function? notDecrementedAction}) async {

        if (cart.quantity > 1) {
            cart.quantity--;
            await _cartService.updateQuantity(cart, cart.quantity);
            getPriceForItem(cart);
            await _cartService.updatePrice(cart, cart.price);
            notifyListeners();
        } else {
            if (deleteOption) {
                await removeItem(cart);
                if(actionAfterDelete!=null){
                    actionAfterDelete();
                }
            } else {
                if(notDecrementedAction!=null){
                    notDecrementedAction();
                }
            }
        }
    }

    double getTotalPrice() {
        double totalPrice = 0;
        for (final Cart cart in _cartList) {
            totalPrice += cart.price * cart.quantity;
        }
        return totalPrice;
    }
    
    double getPriceForItem(Cart cart, {bool updatePrice = false}) {
        if(updatePrice){
            final double total = (cart.quantity * cart.price) as double;
            return total;
        }
        return cart.price;
    }

    int getNumberOfItemsInCart({bool needToIncludeQuantity = true}) {
        if (needToIncludeQuantity){
            int totalQuantity = 0;
            for (final Cart cart in _cartList) {
                totalQuantity += cart.quantity;
            }
            return totalQuantity;
        } else {
            return _cartList.length;
        }
    }
    
    @override
    void dispose() {
        _cartService.dispose();
        super.dispose();
    }
}