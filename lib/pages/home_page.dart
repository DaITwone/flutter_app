// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'; // cần thêm thư viện này
import 'package:my_app/pages/login_page.dart';
import '../data/menu_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // Danh sách ảnh banner (có thể thay bằng ảnh thật sau)
  final List<String> bannerImages = [
    'https://images.pexels.com/photos/437716/pexels-photo-437716.jpeg',
    'https://cdn.pixabay.com/photo/2023/03/15/23/03/ai-generated-7855585_1280.jpg',
    'https://cdn.pixabay.com/photo/2023/02/22/19/13/gruner-tee-7807229_1280.jpg',
    'https://media.istockphoto.com/id/1213819007/vi/anh/bi%E1%BB%87n-ph%C3%A1p-kh%E1%BA%AFc-ph%E1%BB%A5c-c%E1%BA%A3m-l%E1%BA%A1nh-v%C3%A0-c%C3%BAm-th%E1%BB%B1c-ph%E1%BA%A9m-l%C3%A0nh-m%E1%BA%A1nh-mi%E1%BB%85n-d%E1%BB%8Bch-t%C4%83ng-c%C6%B0%E1%BB%9Dng-l%E1%BB%B1a-ch%E1%BB%8Dn.jpg?s=612x612&w=0&k=20&c=kiz4FsjFRHpZduoOxCUC1Gbc-_kn_oKPfzbXqm-8AoY=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Banner tự chuyển ảnh
      body: Column(
        children: [
          const SizedBox(height: 16),
          buildGreetingHeader(),
          const SizedBox(height: 16),
          // Nút Login nằm ngay dưới navbar
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
          // Banner trong Stack để chấm nằm trên ảnh
          Stack(
            alignment:
                Alignment.bottomCenter, // căn dấu chấm ở dưới cùng của ảnh
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

              // Dấu chấm đè lên ảnh
              Positioned(
                bottom: 10, // cách đáy ảnh 10px
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
                              // ignore: duplicate_ignore
                              // ignore: deprecated_member_use
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

          SizedBox(
            height: 220, // chiều cao của list
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryProducts[0]!.length,
              itemBuilder: (context, index) {
                final product = categoryProducts[0]![index];
                return buildBestSellerCard(product);
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildGreetingHeader() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // Avatar tròn
            const CircleAvatar(
              radius: 25,
              backgroundColor: Color(0xFFEFEFEF),
              child: Text(
                'KAT', // Viết tắt tên người dùng (placeholder)
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10),

            // Cột chứa lời chào và tên
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'CHÀO BUỔI SÁNG!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFBE9369), // màu vàng nâu nhẹ
                    fontSize: 13,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Khách',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF023D50), // màu xanh đậm
                  ),
                ),
              ],
            ),
          ],
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

Widget buildBestSellerCard(Map<String, dynamic> product) {
  return Container(
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
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          child: Image.network(
            product['imageUrl'],
            height: 110,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

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
  );
}
