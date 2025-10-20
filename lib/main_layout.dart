import 'package:flutter/material.dart';
// import 'package:my_app/pages/detail_page.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:my_app/pages/menu_page.dart';
// import 'package:my_app/pages/login_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const MenuPage(),
    const HomePage(),
    // const LoginPage(),
    // const DetailPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60), // chiều cao tùy bạn
        child: AppBar(
          backgroundColor: const Color(0xFF023D50),
          centerTitle: true,
          elevation: 0,
          title: Center(
            child: Image.asset(
              'assets/images/logo.png',
              height: 60, // hoặc nhỏ hơn nếu cần
            ),
          ),
        ),
      ),

      body: _pages[_selectedIndex], // chỉ thay đổi phần này
      
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 8, top: 6), // canh giữa Y
        color: const Color(0xFF023D50),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: const Color(0xFFBE9369),
          unselectedItemColor: Colors.white,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Menu'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          ],
        ),
      ),
    );
  }
}
