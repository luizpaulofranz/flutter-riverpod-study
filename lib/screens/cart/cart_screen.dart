import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_files/providers/generated_cart_provider.dart';

// ConsumerStatefulWidget is a riverpod widget that gives us access to providers and the statefull stuff that we are used to
class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

// we need to yse ConsumerState here instead of just State
class _CartScreenState extends ConsumerState<CartScreen> {
  bool showCoupon = true;

  @override
  void initState() {
    super.initState();
    // we have access to the ref object on life cycle methods too
    // ref.read(reducedProductsProvider);
  }

  @override
  Widget build(BuildContext context) {
    // the ref param is automatically passed to the build method
    final cartProducts = ref.watch(generatedCartNotifierProvider);
    final totalPrice = ref.watch(totalPriceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        centerTitle: true,
        // actions: [],
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Column(
              children: cartProducts.map(
                (product) {
                  return Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(children: [
                        Image.asset(product.image, width: 60, height: 60),
                        const SizedBox(width: 10),
                        Text('${product.title}...'),
                        const Expanded(child: SizedBox()),
                        Text('£${product.price}'),
                      ]));
                },
              ).toList(), // output cart products here
            ),

            // output totals here
            Text('Total price: £$totalPrice'),
          ],
        ),
      ),
    );
  }
}
