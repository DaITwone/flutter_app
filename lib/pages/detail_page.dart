// ignore_for_file: use_super_parameters, unnecessary_brace_in_string_interps, deprecated_member_use, unnecessary_to_list_in_spreads
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'cart_page.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String selectedSize = 'S';
  List<String> selectedToppings = [];

  final Map<String, int> toppingPrices = {
    'Trân châu': 5000,
    'Thạch dừa': 5000,
    'Pudding': 7000,
    'Kem cheese': 10000,
  };

  int calculateTotalPrice(int basePrice) {
    int total = basePrice;
    
    // Cộng thêm 5k nếu chọn size L
    if (selectedSize == 'L') {
      total += 5000;
    }
    
    // Cộng giá topping
    for (String topping in selectedToppings) {
      total += toppingPrices[topping] ?? 0;
    }
    
    return total;
  }

  void addToCart(BuildContext context, String title, String imageUrl, int basePrice, int finalPrice) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    
    cart.addItem(
      title: title,
      imageUrl: imageUrl,
      basePrice: basePrice,
      size: selectedSize,
      toppings: List.from(selectedToppings),
      totalPrice: finalPrice,
    );
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Đã thêm "$title" (${selectedSize}) vào giỏ hàng',
          style: const TextStyle(fontSize: 15),
        ),
        backgroundColor: const Color(0xFF003459),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        action: SnackBarAction(
          label: 'Xem giỏ',
          textColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartPage()),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String title = args['title'];
    final String imageUrl = args['imageUrl'];
    final int price = args['price'];
    final int totalPrice = calculateTotalPrice(price);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF003459),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          // Nút giỏ hàng với Consumer để cập nhật realtime
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(),
                        ),
                      );
                    },
                  ),
                  if (cart.totalItems > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Text(
                          '${cart.totalItems}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh sản phẩm
            Hero(
              tag: title,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[300],
                      alignment: Alignment.center,
                      child: const Icon(Icons.broken_image,
                          color: Colors.grey, size: 60),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Tiêu đề + giá gốc
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Color(0xFF002C59),
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${price.toStringAsFixed(0)}đ',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Mô tả sản phẩm
            Text(
              'Mô tả sản phẩm',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[800],
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Thức uống đặc trưng với hương vị đậm đà, được pha chế từ nguyên liệu chọn lọc. '
              'Thích hợp để thưởng thức vào mọi thời điểm trong ngày, mang lại cảm giác sảng khoái và tập trung.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),

            const SizedBox(height: 24),

            // Chọn size
            Text(
              'Chọn size',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[800],
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildSizeOption('S', 'Size S'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSizeOption('L', 'Size L (+5.000đ)'),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Chọn topping
            Text(
              'Thêm topping (Tùy chọn)',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[800],
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            ...toppingPrices.entries.map((entry) {
              return _buildToppingOption(entry.key, entry.value);
            }).toList(),

            const SizedBox(height: 30),

            // Tổng tiền
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tổng cộng:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${totalPrice.toStringAsFixed(0)}đ',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF003459),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Nút thêm vào giỏ hàng
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => addToCart(context, title, imageUrl, price, totalPrice),
                icon: const Icon(Icons.shopping_cart_outlined),
                label: const Text('Thêm vào giỏ hàng'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF003459),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  shadowColor: Colors.black45,
                  elevation: 5,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Nút quay lại
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Quay lại menu'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF003459),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  side: const BorderSide(
                    color: Color(0xFF003459),
                    width: 2,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeOption(String size, String label) {
    final bool isSelected = selectedSize == size;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSize = size;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF003459) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF003459) : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[800],
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToppingOption(String topping, int price) {
    final bool isSelected = selectedToppings.contains(topping);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (isSelected) {
              selectedToppings.remove(topping);
            } else {
              selectedToppings.add(topping);
            }
          });
        },
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFE8F4F8) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? const Color(0xFF003459) : Colors.grey[300]!,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                isSelected
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
                color: isSelected ? const Color(0xFF003459) : Colors.grey,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  topping,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              Text(
                '+${price.toStringAsFixed(0)}đ',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? const Color(0xFF003459) : Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}