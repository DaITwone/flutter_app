// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_app/main_layout.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:my_app/pages/login_page.dart';
import 'package:my_app/pages/user_page.dart';
import '../data/menu_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final _supabase = Supabase.instance.client;
  String userName = 'Khách';
  String userAvatar = 'KAT';
  bool isLoggedIn = false;

  // Danh sách ảnh banner
  final List<String> bannerImages = [
    'https://images.pexels.com/photos/437716/pexels-photo-437716.jpeg',
    'https://cdn.pixabay.com/photo/2023/03/15/23/03/ai-generated-7855585_1280.jpg',
    'https://cdn.pixabay.com/photo/2023/02/22/19/13/gruner-tee-7807229_1280.jpg',
    'https://media.istockphoto.com/id/1213819007/vi/anh/bi%E1%BB%87n-ph%C3%A1p-kh%E1%BA%AFc-ph%E1%BB%A5c-c%E1%BA%A3m-l%E1%BA%A1nh-v%C3%A0-c%C3%BAm-th%E1%BB%B1c-ph%E1%BA%A9m-l%C3%A0nh-m%E1%BA%A1nh-mi%E1%BB%85n-d%E1%BB%8Bch-t%C4%83ng-c%C6%B0%E1%BB%9Dng-l%E1%BB%B1a-ch%E1%BB%8Dn.jpg?s=612x612&w=0&k=20&c=kiz4FsjFRHpZduoOxCUC1Gbc-_kn_oKPfzbXqm-8AoY=',
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();

    // Lắng nghe thay đổi auth state
    _supabase.auth.onAuthStateChange.listen((data) {
      final session = data.session;
      if (mounted) {
        setState(() {
          if (session != null) {
            _loadUserData();
          } else {
            userName = 'Khách';
            userAvatar = 'KAT';
            isLoggedIn = false;
          }
        });
      }
    });
  }

  Future<void> _loadUserData() async {
    final user = _supabase.auth.currentUser;

    if (user != null) {
      setState(() {
        isLoggedIn = true;

        // Lấy tên từ user metadata hoặc email
        if (user.userMetadata?['full_name'] != null) {
          userName = user.userMetadata!['full_name'];
        } else if (user.userMetadata?['name'] != null) {
          userName = user.userMetadata!['name'];
        } else {
          // Nếu không có tên, lấy phần trước @ của email
          userName = user.email?.split('@')[0] ?? 'Người dùng';
        }

        // Tạo avatar từ chữ cái đầu của tên
        userAvatar = _getInitials(userName);
      });
    }
  }

  String _getInitials(String name) {
    List<String> nameParts = name.trim().split(' ');
    if (nameParts.isEmpty) return 'KAT';

    if (nameParts.length == 1) {
      return nameParts[0].substring(0, 1).toUpperCase();
    } else {
      return (nameParts[0].substring(0, 1) +
              nameParts[nameParts.length - 1].substring(0, 1))
          .toUpperCase();
    }
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'CHÀO BUỔI SÁNG!';
    } else if (hour < 18) {
      return 'CHÀO BUỔI CHIỀU!';
    } else {
      return 'CHÀO BUỔI TỐI!';
    }
  }

  void _navigateToUserPage() {
    if (isLoggedIn) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainLayout(child: UserPage()),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainLayout(child: LoginPage()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 16),
          _buildGreetingHeader(),
          const SizedBox(height: 16),

          // Nút Login/Logout
          if (!isLoggedIn)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(225, 207, 171, 92),
                  minimumSize: const Size.fromHeight(45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text(
                  'Đăng nhập/Đăng ký',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),

          const SizedBox(height: 16),

          // Banner
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: bannerImages.map((imageUrl) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  );
                }).toList(),
              ),

              // Dấu chấm indicator
              Positioned(
                bottom: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: bannerImages.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => setState(() => _currentIndex = entry.key),
                      child: Container(
                        width: 10.0,
                        height: 10.0,
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == entry.key
                              ? const Color(0xFFBE9369)
                              : Colors.white.withOpacity(0.6),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Section: Best Seller
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Best Seller',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF023D50),
                  ),
                ),
                Text(
                  'Xem tất cả',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFBE9369),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // List Best Seller
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryProducts[0]!.length,
              itemBuilder: (context, index) {
                final product = categoryProducts[0]![index];
                return _buildBestSellerCard(product);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGreetingHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Phát hiện, xử lý mọi loại cử chỉ, biến các widget tĩnh thành các thành phần tương tác
          GestureDetector(
            onTap: _navigateToUserPage,
            child: Row(
              children: [
                // Avatar tròn
                CircleAvatar(
                  radius: 25,
                  backgroundColor: const Color(0xFFBE9369).withOpacity(0.2),
                  child: Text(
                    userAvatar,
                    style: const TextStyle(
                      color: Color(0xFF023D50),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // Cột chứa lời chào và tên
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getGreeting(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFBE9369),
                        fontSize: 13,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF023D50),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Icon chuông bên phải
          IconButton(
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Color(0xFF023D50),
              size: 26,
            ),
            onPressed: () {
              //
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBestSellerCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        // Điều hướng đến trang chi tiết sản phẩm
        Navigator.pushNamed(
          context,
          '/detail',
          arguments: {
            'title': product['title'],
            'imageUrl': product['imageUrl'],
            'price': product['price'],
          },
        );
      },
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh sản phẩm
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              child: Image.network(
                product['imageUrl'],
                height: 110,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 110,
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, size: 50),
                ),
              ),
            ),

            // Tạo khoảng trống (đệm) giữa nội dung (widget con) của nó và các cạnh (biên) của chính nó.
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['title'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF023D50),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '${product['price']}đ',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFBE9369),
                        ),
                      ),
                      const SizedBox(width: 6),
                      if (product.containsKey('oldPrice'))
                        Text(
                          '${product['oldPrice']}đ',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  if (product.containsKey('discount'))
                    Text(
                      product['discount'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
