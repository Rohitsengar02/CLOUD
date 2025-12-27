import 'package:cloud_user/core/models/service_model.dart';
import 'package:cloud_user/features/cart/data/cart_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_provider.g.dart';

@Riverpod(keepAlive: true)
class Cart extends _$Cart {
  @override
  List<CartItem> build() {
    return [];
  }

  void addToCart(ServiceModel service) {
    // Check if item exists, if so increment quantity
    final index = state.indexWhere((item) => item.service.id == service.id);
    if (index >= 0) {
      final oldItem = state[index];
      final newItem = CartItem(service: service, quantity: oldItem.quantity + 1);
      final newState = [...state];
      newState[index] = newItem;
      state = newState;
    } else {
      state = [...state, CartItem(service: service, quantity: 1)];
    }
  }

  void removeFromCart(String serviceId) {
    state = state.where((item) => item.service.id != serviceId).toList();
  }

  void clearCart() {
    state = [];
  }
}

@riverpod
double cartTotal(CartTotalRef ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(0, (sum, item) => sum + item.totalPrice);
}
