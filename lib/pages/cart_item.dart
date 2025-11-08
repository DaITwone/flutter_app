class CartItem {
  final String id;
  final String title;
  final String imageUrl;
  final int basePrice;
  final String size;
  final List<String> toppings;
  final int totalPrice;
  int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.basePrice,
    required this.size,
    required this.toppings,
    required this.totalPrice,
    this.quantity = 1,
  });

  // Tạo ID duy nhất dựa trên sản phẩm, size và topping
  static String generateId(String title, String size, List<String> toppings) {
    final toppingStr = toppings.join(',');
    return '${title}_${size}_$toppingStr';
  }

  // Tính tổng giá cho item này (giá * số lượng)
  int get itemTotal => totalPrice * quantity;

  // Copy with
  CartItem copyWith({
    String? id,
    String? title,
    String? imageUrl,
    int? basePrice,
    String? size,
    List<String>? toppings,
    int? totalPrice,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      basePrice: basePrice ?? this.basePrice,
      size: size ?? this.size,
      toppings: toppings ?? this.toppings,
      totalPrice: totalPrice ?? this.totalPrice,
      quantity: quantity ?? this.quantity,
    );
  }
}