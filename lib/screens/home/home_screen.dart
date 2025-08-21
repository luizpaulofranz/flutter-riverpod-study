import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_files/providers/generated_cart_provider.dart';
import 'package:riverpod_files/providers/products_provider.dart';
import 'package:riverpod_files/shared/cart_icon.dart';

// ConsumerWidget is Riverpod widget that works like a Stateless
// and it have access to the providers through the ref parameter at the build method
// we can also use Consumer Widget at the build method instead of these Widget classes
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  // ref object is kinda like the BuildContext, but for riverpod providers
  // we use it to read / listen to providers, check if a provider is loaded or reset it's state
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // this is how we get a provider
    // we have ref.read too, to only read once
    // watch is used to listen to the provider and rebuild the widget when the provider changes
    final products = ref.watch(productsProvider);

    // this is a notifier provider (stateful provider), it works the same at the screen side
    // but it is different at the provider declaration side
    final cartProducts = ref.watch(generatedCartNotifierProvider);

    // we could use Consumer Widget at the build method instead of extend ConsumerWidget
    //return Consumer(
    // The "builder" callback gives us a "ref" parameter
    // builder: (context, ref, _) {
    //   return Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Garage Sale Products'),
    //       actions: const [CartIcon()],
    //     ),
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Garage Sale Products'),
        actions: const [CartIcon()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return Container(
              padding: const EdgeInsets.all(20),
              color: Colors.blueGrey.withValues(alpha: 0.05),
              child: Column(
                children: [
                  Image.asset(product.image, width: 60, height: 60),
                  Text(product.title),
                  Text('£${product.price}'),
                  if (cartProducts.contains(product))
                    TextButton(
                      onPressed: () {
                        // this is how we retrieve a notifier provider to take actions on it
                        // we use read because we should not trigger a rebuild of the widget
                        // and we must access the .notifier to call the methods
                        ref
                            .read(generatedCartNotifierProvider.notifier)
                            .removeProduct(product);
                      },
                      child: const Text('Remove'),
                    ),
                  if (!cartProducts.contains(product))
                    TextButton(
                      onPressed: () {
                        // this is how we retrieve a notifier provider to take actions on it
                        // we use read because we should not trigger a rebuild of the widget
                        // and we must access the .notifier to call the methods
                        ref
                            .read(generatedCartNotifierProvider.notifier)
                            .addProduct(product);
                      },
                      child: const Text('Add to Cart'),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
