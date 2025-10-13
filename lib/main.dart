import 'package:flutter/material.dart';
import 'package:my_app/main_layout.dart';
// import 'package:my_app/pages/home_page.dart';
// import 'package:my_app/pages/login_page.dart';
const primaryColor = Color(0xFF023D50);
// const primaryColor1 = Color.fromARGB(225, 207, 171, 92);
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katinat App',
      theme: ThemeData(
        primaryColor: primaryColor,
        fontFamily: 'Roboto',
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFBE9369), width: 2),
            // màu khi focus
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24, width: 1),
            // màu viền khi chưa focus
            borderRadius: BorderRadius.circular(12),
          ),
          hintStyle: const TextStyle(color: Colors.blueGrey), // màu chữ gợi ý
        ),
      ),
      home: const MainLayout(),
    );
  }
}
