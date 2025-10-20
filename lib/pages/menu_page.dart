// ignore_for_file: use_super_parameters
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_app/pages/detail_page.dart';

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
    0: [
      // Ưu đãi
      {
        'title': 'COMBO NĂNG LƯỢNG',
        'price': 75000,
        'oldPrice': 99000,
        'discount': '-24%',
        'imageUrl':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTC-T51BJzl50EMbE9jUkw6aVhJFe5h52t7Dg&s',
      },
      {
        'title': 'COMBO LẤP LÁNH',
        'price': 159000,
        'oldPrice': 228000,
        'discount': '-30%',
        'imageUrl':
            'https://chus.vn/images/Blog/Tea%20of%20coffee/Coffee-or-Tea-For-Seniors-min.jpg?1712138278025',
      },
    ],
    1: [
      // Tea
      {
        'title': 'Trà Đào',
        'price': 45000,
        'imageUrl':
            'https://hocphachehanoi.com.vn/upload/userfiles/images/cach-lam-tra-dao-02.jpg',
      },
      {
        'title': 'Trà Vải',
        'price': 45000,
        'imageUrl':
            'https://bizweb.dktcdn.net/100/421/036/files/tra-cam-sa-vai.jpg?v=1639043038068',
      },
      {
        'title': 'Trà Sen Vàng',
        'price': 50000,
        'imageUrl':
            'https://bepchethai.vn/wp-content/uploads/2023/02/tra-sen-vang-machiato-3-500x500.jpg',
      },
      {
        'title': 'Trà Dâu',
        'price': 50000,
        'imageUrl':
            'https://amivietnam.com/wp-content/uploads/2024/03/image-47.png',
      },
      {
        'title': 'Trà Trái Cây Nhiệt Đới',
        'price': 50000,
        'imageUrl':
            'https://cdn.sobanhang.com/v2/2000x2000/finan-prd/81d39d68-5ff6-4692-b918-a372b6bf6ab4/image/e416d0ab-993c-4efe-9dca-9a7b9e7372de.jpeg',
      },
      {
        'title': 'Trà Ổi Hồng',
        'price': 50000,
        'imageUrl':
            'https://cdn.tgdd.vn/2021/06/CookProductThumb/toh2-620x620.jpg',
      },
    ],
    2: [
      // Coffee
      {
        'title': 'Cà Phê Sữa Đá',
        'price': 35000,
        'imageUrl':
            'https://www.huongnghiepaau.com/wp-content/uploads/2024/07/cong-thuc-lam-ca-phe-sua-tuoi.jpg',
      },
      {
        'title': 'Bạc Xỉu',
        'price': 35000,
        'imageUrl': 'https://www.lorca.vn/wp-content/uploads/2023/10/1-29.jpg',
      },
      {
        'title': 'Cà Phê Đen Đá',
        'price': 32000,
        'imageUrl':
            'https://banhmibahuynh.vn/wp-content/uploads/2025/06/Ca-phe-den-da-Madam-Win.jpg',
      },
      {
        'title': 'Capuchino',
        'price': 45000,
        'imageUrl':
            'https://cdn1.123job.vn/123job/uploads/2021/09/27/2021_09_27______7c79422cc3229dbda950a5b5db38c2f6.jpg',
      },
      {
        'title': 'Cà Phê Trứng',
        'price': 45000,
        'imageUrl':
            'https://traphucsang.vn/wp-content/uploads/2025/08/cach-pha-ca-phe-trung-ngon-nhat.jpg',
      },
      {
        'title': 'Cà Phê Muối',
        'price': 45000,
        'imageUrl':
            'https://viettuantea.vn/wp-content/uploads/2023/09/cach-lam-ca-phe-muoi-1024x1024.jpg',
      },
    ],
    3: [
      // Matcha
      {
        'title': 'Matcha Latte',
        'price': 55000,
        'imageUrl':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrJrTp_PHyT7ifNbQ-DtZU6MQQ2mFe6mcnZg&s',
      },
      {
        'title': 'Matcha Đá Xay',
        'price': 60000,
        'imageUrl': 'https://thecoffeeholic.vn/storage/photos/2/H2M/ice/1.JPG',
      },
      {
        'title': 'Matcha Macchiato',
        'price': 58000,
        'imageUrl':
            'https://uories.com/wp-content/uploads/2020/03/MatchaMacchiato_www.uories.com_2.jpg',
      },
      {
        'title': 'Matcha Đậu đỏ',
        'price': 58000,
        'imageUrl':
            'https://horecavn.com/wp-content/uploads/2024/05/tra-sua-matcha-dau-do_20240527105057.jpg',
      },
      {
        'title': 'Matcha Dâu Latte',
        'price': 58000,
        'imageUrl':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSED-nzJRiHzcsJ9y6UUhlr0Etp8su7LENeDw&s',
      },
    ],
    4: [
      // Milk Tea
      {
        'title': 'Trà Sữa Trân Châu',
        'price': 48000,
        'imageUrl':
            'https://dayphache.edu.vn/wp-content/uploads/2020/02/mon-tra-sua-tran-chau.jpg',
      },
      {
        'title': 'Trà Sữa Ô Long',
        'price': 52000,
        'imageUrl':
            'https://static.wixstatic.com/media/57d3ad_eb3fc685e016483bbf860c01f0fdb13f~mv2.png/v1/fill/w_568,h_444,al_c,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/57d3ad_eb3fc685e016483bbf860c01f0fdb13f~mv2.png',
      },
      {
        'title': 'Trà Sữa Matcha',
        'price': 55000,
        'imageUrl':
            'https://file.hstatic.net/200000538679/article/cach-lam-tra-sua-matcha-chuan-vi-thom-ngon-tai-nha5_44906aa466224a9480f09cdc28f19e44.jpg',
      },
      {
        'title': 'Trà Sữa Thái xanh',
        'price': 40000,
        'imageUrl':
            'https://i-giadinh.vnecdn.net/2021/09/11/Trasua1-1631341310-9389-1631341336.jpg',
      },
      {
        'title': 'Sữa tươi trân châu đường đen',
        'price': 48000,
        'imageUrl':
            'https://blog.dktcdn.net/files/sua-tuoi-tran-chau-duong-den-001.png',
      },
    ],
    5: [
      // Bánh
      {
        'title': 'Bánh Mì Que',
        'price': 15000,
        'imageUrl':
            'https://tvpfood.com/wp-content/uploads/2024/10/banh-mi-que-minh-hoa-1-1.png',
      },
      {
        'title': 'Bánh Croissant',
        'price': 28000,
        'imageUrl': 'https://winci.com.vn/wp-content/uploads/2024/02/h-7.png',
      },
      {
        'title': 'Bánh Tiramisu',
        'price': 38000,
        'imageUrl':
            'https://daotaobeptruong.vn/wp-content/uploads/2020/11/banh-tiramisu.jpg',
      },
      {
        'title': 'Bánh Tiramisu Matcha',
        'price': 38000,
        'imageUrl':
            'https://cdn.tgdd.vn/2021/03/CookProduct/1200-1200x676-97.jpg',
      },
      {
        'title': 'Panna Cotta',
        'price': 40000,
        'imageUrl':
            'https://file.hstatic.net/200000692767/file/cach-lam-panna-cotta__3_.png',
      },
      {
        'title': 'Panna Cotta Coffee',
        'price': 44000,
        'imageUrl':
            'https://media.vneconomy.vn/images/upload/2021/04/21/ca-phe-15350831171861391119733.jpg?w=600',
      },
    ],
    6: [
      // Topping
      {
        'title': 'Trân Châu Đen',
        'price': 8000,
        'imageUrl':
            'https://chapatea.vn/wp-content/uploads/2025/01/tran-chau-den-8734.jpeg',
      },
      {
        'title': 'Trân Châu Trắng',
        'price': 10000,
        'imageUrl':
            'https://alltop.vn/backend/media/images/posts/695/Tran_Chau_Trang_3Q_Ezmix-128334.jpg',
      },
      {
        'title': 'Thạch Phô Mai',
        'price': 12000,
        'imageUrl':
            'https://storage.googleapis.com/onelife-public/blog.onelife.vn/2021/10/cach-lam-thach-rau-cau-ca-phe-pho-mai-mon-trang-mieng-780259497769.jpg',
      },
      {
        'title': 'Bánh Plan',
        'price': 10000,
        'imageUrl':
            'https://savourebakery.com/storage/images/san-pham/Banh-lanh/Banh-Flan-2.jpg',
      },
      {
        'title': 'Kem Cheese',
        'price': 12000,
        'imageUrl':
            'https://bizweb.dktcdn.net/100/439/247/products/5b9b880f-fb55-438f-9c89-adc684dc51bd.png?v=1656341171563',
      },
      {
        'title': 'Thạch dừa',
        'price': 9000,
        'imageUrl':
            'https://goce.vn/files/common/thach-dua-huong-vai-5btgg.png',
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

    if (products.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            'Đang cập nhật...',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailPage(title: title, imageUrl: imageUrl, price: price),
          ),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
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

  // Container - bao bọc, trang trí, định kích thước và bố trí con của nó.
  Widget _buildCartButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      // Trang trí
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
