// Constructor: là một phương thức đặc biệt trong một class được gọi ngay lập tức khi bạn tạo ra một đối tượng (instance) mới của class đó.
// Khởi tạo Trạng thái: Gán giá trị ban đầu cho các thuộc tính (fields) của đối tượng.
// Thiết lập Bắt buộc: Đảm bảo đối tượng được tạo ra ở trạng thái hợp lệ, bằng cách yêu cầu các dữ liệu cần thiết.
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
    this.quantity = 1, // Mặc định sl = 1
  });

  // Tạo ID duy nhất dựa trên sản phẩm, size và topping
  static String generateId(String title, String size, List<String> toppings) {
    final toppingStr = toppings.join(',');
    return '${title}_${size}_$toppingStr';
  }

  // Tính tổng giá cho item này (giá * số lượng)
  int get itemTotal => totalPrice * quantity;

  // Copy with
  // Vì các thuộc tính dùng final, không thể thay đổi trực tiếp
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