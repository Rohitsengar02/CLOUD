import 'package:cloud_user/core/models/service_model.dart';

class CartItem {
  final ServiceModel service;
  final int quantity;

  CartItem({required this.service, required this.quantity});

  double get totalPrice => service.price * quantity;
}
