// ignore_for_file: use_super_parameters, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../data/menu_data.dart';
import '../providers/cart_provider.dart';
import 'cart_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int selectedTab = 0;
  bool isDelivery = true;
  int selectedCategory = 0;
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<String> tabs = [
    'Tất cả',
    'Best Seller',
    'Món ngon phải thử',
  ];

  final List<Map<String, dynamic>> sidebarItems = [
    {'icon': FontAwesomeIcons.tags, 'label': 'Ưu đãi'},
    {'icon': FontAwesomeIcons.mugSaucer, 'label': 'Tea'},
    {'icon': FontAwesomeIcons.mugHot, 'label': 'Coffee'},
    {'icon': FontAwesomeIcons.leaf, 'label': 'Matcha'},
    {'icon': FontAwesomeIcons.glassWater, 'label': 'Milk Tea'},
    {'icon': FontAwesomeIcons.cheese, 'label': 'Bánh'},
    {'icon': FontAwesomeIcons.cookie, 'label': 'Topping'},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Hàm lọc sản phẩm theo từ khóa tìm kiếm
  List<Map<String, dynamic>> _filterProducts(List<Map<String, dynamic>> products) {
    if (searchQuery.isEmpty) {
      return products;
    }
    
    return products.where((product) {
      final title = product['title'].toString().toLowerCase();
      final query = searchQuery.toLowerCase();
      return title.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // SafeArea giúp nội dung của bạn luôn nằm trong "vùng an toàn" và không bị các yếu tố hệ thống can thiệp.
      body: SafeArea(
        child: Row(
          children: [
            _buildSidebar(),
            Expanded(
              child: Column(
                children: [
                  _buildSearchBar(),
                  const SizedBox(height: 8),
                  _buildTabs(),
                  const SizedBox(height: 12),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sidebarItems[selectedCategory]['label']
                                  .toString()
                                  .toUpperCase(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildProductList(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildCartButton(),
    );
  }

  Widget _buildProductList() {
    final products = categoryProducts[selectedCategory] ?? [];
    final filteredProducts = _filterProducts(products);

    if (filteredProducts.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Icon(
                searchQuery.isNotEmpty ? Icons.search_off : Icons.inbox_outlined,
                size: 80,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                searchQuery.isNotEmpty 
                    ? 'Không tìm thấy sản phẩm nào\nphù hợp với "$searchQuery"'
                    : 'Đang cập nhật...',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      );
    }

    // Hiển thị tất cả category theo dạng grid thống nhất
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];
        
        // Kiểm tra xem có phải là ưu đãi không (có oldPrice và discount)
        bool isPromo = product.containsKey('oldPrice') && 
                       product.containsKey('discount');
        
        if (isPromo) {
          return _productCardWithDiscount(
            title: product['title'],
            price: product['price'],
            oldPrice: product['oldPrice'],
            discount: product['discount'],
            imageUrl: product['imageUrl'],
          );
        } else {
          return _productCard(
            title: product['title'],
            price: product['price'],
            imageUrl: product['imageUrl'],
          );
        }
      },
    );
  }

  // Card sản phẩm thường (không có khuyến mãi)
  Widget _productCard({
    required String title,
    required int price,
    required String imageUrl,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/detail',
          arguments: {'title': title, 'imageUrl': imageUrl, 'price': price},
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, size: 50),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${price.toStringAsFixed(0)}đ',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const Icon(
                        Icons.add_circle_outline,
                        color: Color(0xFF003459),
                        size: 24,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Card sản phẩm có khuyến mãi
  Widget _productCardWithDiscount({
    required String title,
    required int price,
    required int oldPrice,
    required String discount,
    required String imageUrl,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/detail',
          arguments: {'title': title, 'imageUrl': imageUrl, 'price': price},
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.network(
                      imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.broken_image, size: 50),
                      ),
                    ),
                  ),
                  // Badge giảm giá
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        discount,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${price.toStringAsFixed(0)}đ',
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            '${oldPrice.toStringAsFixed(0)}đ',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.add_circle_outline,
                        color: Color(0xFF003459),
                        size: 24,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          for (int i = 0; i < sidebarItems.length; i++)
            _sidebarItem(
              icon: sidebarItems[i]['icon'],
              label: sidebarItems[i]['label'],
              active: i == selectedCategory,
              onTap: () {
                setState(() {
                  selectedCategory = i;
                  // Clear search khi chuyển category
                  searchQuery = '';
                  _searchController.clear();
                });
              },
            ),
        ],
      ),
    );
  }

  Widget _sidebarItem({
    required IconData icon,
    required String label,
    required bool active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 28,
              color: active ? const Color(0xFF003459) : Colors.grey,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: active ? const Color(0xFF003459) : Colors.grey,
                fontWeight: active ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Katies muốn tìm gì?',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            searchQuery = '';
                            _searchController.clear();
                          });
                        },
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          _buildToggleButton(),
        ],
      ),
    );
  }

  Widget _buildToggleButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _toggleItem('Giao hàng', isDelivery),
          _toggleItem('Đến lấy', !isDelivery),
        ],
      ),
    );
  }

  Widget _toggleItem(String label, bool active) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDelivery = (label == 'Giao hàng');
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF003459) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(tabs.length, (index) {
          bool isSelected = index == selectedTab;
          return GestureDetector(
            onTap: () => setState(() => selectedTab = index),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Text(
                    tabs[index],
                    style: TextStyle(
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isSelected ? Colors.black : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (isSelected)
                    Container(
                      width: 20,
                      height: 3,
                      decoration: BoxDecoration(
                        color: const Color(0xFF003459),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCartButton() {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartPage()),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF003459),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                    if (cart.totalItems > 0)
                      Positioned(
                        right: -2,
                        top: -2,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
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
                ),
                const SizedBox(width: 8),
                Text(
                  cart.totalAmount > 0 
                      ? '${cart.totalAmount}đ'
                      : '0đ',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}