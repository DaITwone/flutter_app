import 'package:flutter/material.dart';
import 'package:my_app/pages/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount {
    return _items.length;
  }

  int get totalItems {
    int total = 0;
    _items.forEach((key, item) {
      total += item.quantity;
    });
    return total;
  }

  int get totalAmount {
    int total = 0;
    _items.forEach((key, item) {
      total += item.itemTotal;
    });
    return total;
  }

  void addItem({
    required String title,
    required String imageUrl,
    required int basePrice,
    required String size,
    required List<String> toppings,
    required int totalPrice,
  }) {
    final id = CartItem.generateId(title, size, toppings);

    if (_items.containsKey(id)) {
      // Nếu đã có sản phẩm này, tăng số lượng
      _items.update(
        id,
        (existingItem) => existingItem.copyWith(
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      // Thêm sản phẩm mới
      _items.putIfAbsent(
        id,
        () => CartItem(
          id: id,
          title: title,
          imageUrl: imageUrl,
          basePrice: basePrice,
          size: size,
          toppings: toppings,
          totalPrice: totalPrice,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void decreaseQuantity(String id) {
    if (!_items.containsKey(id)) return;

    if (_items[id]!.quantity > 1) {
      _items.update(
        id,
        (existingItem) => existingItem.copyWith(
          quantity: existingItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(id);
    }
    notifyListeners();
  }

  void increaseQuantity(String id) {
    if (!_items.containsKey(id)) return;

    _items.update(
      id,
      (existingItem) => existingItem.copyWith(
        quantity: existingItem.quantity + 1,
      ),
    );
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}