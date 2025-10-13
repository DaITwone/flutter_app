import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int selectedTab = 0;
  bool isDelivery = true;
  int selectedCategory = 0;

  final List<String> tabs = [
    'Tất cả',
    'Happy Hour',
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

  // Dữ liệu sản phẩm cho từng category
  final Map<int, List<Map<String, dynamic>>> categoryProducts = {
    0: [ // Ưu đãi
      {
        'title': 'COMBO NĂNG LƯỢNG',
        'price': 75000,
        'oldPrice': 99000,
        'discount': '-24%',
        'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTC-T51BJzl50EMbE9jUkw6aVhJFe5h52t7Dg&s',
      },
      {
        'title': 'COMBO LẤP LÁNH',
        'price': 159000,
        'oldPrice': 228000,
        'discount': '-30%',
        'imageUrl': 'https://chus.vn/images/Blog/Tea%20of%20coffee/Coffee-or-Tea-For-Seniors-min.jpg?1712138278025',
      },
    ],
    1: [ // Tea
      {
        'title': 'Trà Đào',
        'price': 45000,
        'imageUrl': 'https://hocphachehanoi.com.vn/upload/userfiles/images/cach-lam-tra-dao-02.jpg',
      },
      {
        'title': 'Trà Vải',
        'price': 45000,
        'imageUrl': 'https://bizweb.dktcdn.net/100/421/036/files/tra-cam-sa-vai.jpg?v=1639043038068',
      },
      {
        'title': 'Trá Sen Vàng',
        'price': 50000,
        'imageUrl': 'https://bepchethai.vn/wp-content/uploads/2023/02/tra-sen-vang-machiato-3-500x500.jpg',
      },
    ],
    2: [ // Coffee
      {
        'title': 'Cà Phê Sữa Đá',
        'price': 35000,
        'imageUrl': 'https://www.huongnghiepaau.com/wp-content/uploads/2024/07/cong-thuc-lam-ca-phe-sua-tuoi.jpg',
      },
      {
        'title': 'Bạc Xỉu',
        'price': 35000,
        'imageUrl': 'https://www.lorca.vn/wp-content/uploads/2023/10/1-29.jpg',
      },
      {
        'title': 'Cà Phê Đen Đá',
        'price': 32000,
        'imageUrl': 'https://banhmibahuynh.vn/wp-content/uploads/2025/06/Ca-phe-den-da-Madam-Win.jpg',
      },
    ],
    3: [ // Matcha
      {
        'title': 'Matcha Latte',
        'price': 55000,
        'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrJrTp_PHyT7ifNbQ-DtZU6MQQ2mFe6mcnZg&s',
      },
      {
        'title': 'Matcha Đá Xay',
        'price': 60000,
        'imageUrl': 'https://thecoffeeholic.vn/storage/photos/2/H2M/ice/1.JPG',
      },
      {
        'title': 'Matcha Macchiato',
        'price': 58000,
        'imageUrl': 'https://uories.com/wp-content/uploads/2020/03/MatchaMacchiato_www.uories.com_2.jpg',
      },
    ],
    4: [ // Milk Tea
      {
        'title': 'Trà Sữa Trân Châu',
        'price': 48000,
        'imageUrl': 'https://dayphache.edu.vn/wp-content/uploads/2020/02/mon-tra-sua-tran-chau.jpg',
      },
      {
        'title': 'Trà Sữa Ô Long',
        'price': 52000,
        'imageUrl': 'https://static.wixstatic.com/media/57d3ad_eb3fc685e016483bbf860c01f0fdb13f~mv2.png/v1/fill/w_568,h_444,al_c,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/57d3ad_eb3fc685e016483bbf860c01f0fdb13f~mv2.png',
      },
      {
        'title': 'Trà Sữa Matcha',
        'price': 55000,
        'imageUrl': 'https://file.hstatic.net/200000538679/article/cach-lam-tra-sua-matcha-chuan-vi-thom-ngon-tai-nha5_44906aa466224a9480f09cdc28f19e44.jpg',
      },
    ],
    5: [ // Bánh
      {
        'title': 'Bánh Mì Que',
        'price': 15000,
        'imageUrl': 'https://product.hstatic.net/200000688689/product/banh-mi-que_632028_400x400.jpg',
      },
      {
        'title': 'Bánh Croissant',
        'price': 28000,
        'imageUrl': 'https://product.hstatic.net/1000075078/product/croissant_f96e24c4a93a42e6b306ed2e4ea4c57b_grande.jpg',
      },
      {
        'title': 'Bánh Tiramisu',
        'price': 38000,
        'imageUrl': 'https://bizweb.dktcdn.net/100/336/794/products/banh-tiramisu.jpg?v=1614587488490',
      },
    ],
    6: [ // Topping
      {
        'title': 'Trân Châu Đen',
        'price': 10000,
        'imageUrl': 'https://product.hstatic.net/200000688689/product/tran-chau-den_513417_400x400.jpg',
      },
      {
        'title': 'Trân Châu Trắng',
        'price': 10000,
        'imageUrl': 'https://product.hstatic.net/1000075078/product/tran-chau-trang_grande.jpg',
      },
      {
        'title': 'Thạch Phô Mai',
        'price': 12000,
        'imageUrl': 'https://product.hstatic.net/200000688689/product/thach-pho-mai_461810_400x400.jpg',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                              sidebarItems[selectedCategory]['label'].toString().toUpperCase(),
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
    
    if (products.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            'Đang cập nhật...',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ),
      );
    }

    // Hiển thị theo dạng promo cards cho ưu đãi, grid cho các category khác
    if (selectedCategory == 0) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: products.map((product) {
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: _promoCard(
                title: product['title'],
                oldPrice: product['oldPrice'],
                newPrice: product['price'],
                discount: product['discount'],
                imageUrl: product['imageUrl'],
              ),
            );
          }).toList(),
        ),
      );
    } else {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return _productCard(
            title: product['title'],
            price: product['price'],
            imageUrl: product['imageUrl'],
          );
        },
      );
    }
  }

  Widget _productCard({
    required String title,
    required int price,
    required String imageUrl,
  }) {
    return Container(
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
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
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
              decoration: InputDecoration(
                hintText: 'Katies muốn tìm gì?',
                prefixIcon: const Icon(Icons.search),
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
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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

  Widget _promoCard({
    required String title,
    required int oldPrice,
    required int newPrice,
    required String discount,
    required String imageUrl,
  }) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(8),
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
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(imageUrl, height: 120, fit: BoxFit.cover),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.brown[300],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    discount,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            '${newPrice.toStringAsFixed(0)}đ',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${oldPrice.toStringAsFixed(0)}đ',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          const SizedBox(height: 4),
          const Icon(Icons.add_circle_outline, color: Color(0xFF003459)),
        ],
      ),
    );
  }

  Widget _buildCartButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF003459),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.shopping_bag_outlined, color: Colors.white),
          SizedBox(width: 8),
          Text(
            '0đ',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}