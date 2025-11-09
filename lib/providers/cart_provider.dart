import 'package:flutter/material.dart';
import 'package:my_app/pages/cart_item.dart';

// ChangeNotifier là class từ Flutter cho phép thông báo (notify) cho UI khi có thay đổi
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
    // Khi gọi notifyListeners() → tất cả widget đang lắng nghe sẽ rebuild
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  // Giảm số lượng 
  void decreaseQuantity(String id) {
    if (!_items.containsKey(id)) return; // Không tồn tại -> dừng

    if (_items[id]!.quantity > 1) {
      _items.update(
        id,
        (existingItem) => existingItem.copyWith(
          quantity: existingItem.quantity - 1,
        ),
      );
    } else {
      // quantity = 1 → xóa luôn
      _items.remove(id);
    }
    notifyListeners();
  }

  // Tăng số lượng 
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

  // Xóa toàn bộ giỏ hàng
  void clear() {
    _items.clear();
    notifyListeners();
  }
}