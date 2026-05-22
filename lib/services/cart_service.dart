import 'package:flutter/material.dart';
import '../models/category.dart';

class CartService extends ChangeNotifier {
  final Map<int, ItemMenu> _cartItems = {};

  Map<int, ItemMenu> get cartItems => _cartItems;

  int get totalItems => _cartItems.length;

  double get totalPrice {
    return _cartItems.values.fold(0.0, (sum, item) => sum + item.precItem);
  }

  void addItem(ItemMenu item) {
    _cartItems[item.id] = item;
    notifyListeners();
  }

  void removeItem(int itemId) {
    _cartItems.remove(itemId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
