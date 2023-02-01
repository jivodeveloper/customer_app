import 'package:customer_app/notifiers/CartNotifiers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class TotalItemsCartWidget extends ConsumerWidget {
  final bool needToIncludeQuantity;
  final Widget Function(int totalItems) totalItemsBuilder;
  const TotalItemsCartWidget({Key? key, this.needToIncludeQuantity = true, required this.totalItemsBuilder}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    ref.watch(CartNotifiers.provider);
    final totalItems = ref.watch(CartNotifiers.provider.notifier).getNumberOfItemsInCart(needToIncludeQuantity: needToIncludeQuantity);
    return totalItemsBuilder(totalItems);
  }
}
