import 'package:customer_app/Model/Cart.dart';
import 'package:customer_app/notifiers/CartNotifiers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddToCartButton extends ConsumerWidget {
  final Widget child;
  final Function? actionAfterAdding;
  final Cart cartModel;
  const AddToCartButton({Key? key, required this.child, this.actionAfterAdding,required this.cartModel})
      : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return GestureDetector(
      onTap: (){
        // ref.read(CartNotifiers.provider.notifier).addItem(cartModel);
        // if(actionAfterAdding != null){
        //   actionAfterAdding!();
        // }
      },
      child: child,
    );
  }

}
