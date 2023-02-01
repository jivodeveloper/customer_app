import 'package:customer_app/notifiers/CartNotifiers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CartWidget extends ConsumerWidget {
  final Widget Function(CartNotifiers controller) cartBuilder;

  const CartWidget({Key? key, required this.cartBuilder}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(CartNotifiers.provider);
    final controller = ref.watch(CartNotifiers.provider.notifier);
    return cartBuilder(controller);
  }
}
