import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_files/models/product.dart';
// THIS IS NOT BEING USED, IT IS JUST FOR DEMONSTRATION PURPOSES, WE ARE USING THE GENERATED CART PROVIDER INSTEAD

// Notifier Providers
// use when you need to update the state & notify consumers
class ManualCartNotifier extends Notifier<Set<Product>> {
  // this is the initial state
  @override
  Set<Product> build() {
    return const {
      Product(
        id: '4',
        title: 'Red Backpack',
        price: 14,
        image: 'assets/products/backpack.png',
      ),
    };
  }

  // methods to update state
  void addProduct(Product product) {
    // state is a notifier inner object its type is Set<Product> declared at the top
    // is is immutable, so we need to create a new set with the new product
    // we are using Set instead of a List because it is faster to check if an item is in the set and we only want unique items
    if (!state.contains(product)) {
      state = {...state, product};
    }
  }

  void removeProduct(Product product) {
    state = state.where((p) => p.id != product.id).toSet();
  }
}

// this is the way to create a provider that have state, we first need a Notifier, than we provide it
// at the screen side, all works the same, ref.watch or ref.read or even ref.listen
final manualCartNotifierProvider =
    NotifierProvider<ManualCartNotifier, Set<Product>>(() {
  return ManualCartNotifier();
});
