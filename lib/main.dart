import 'package:flutter/material.dart';
import 'package:my_app/pages/cart_page.dart';
import 'package:my_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:my_app/main_layout.dart';
import 'package:my_app/supabase_config.dart';
import 'package:my_app/pages/detail_page.dart';

const primaryColor = Color(0xFF023D50);

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Đảm bảo Flutter đã được khởi tạo trước khi gọi các API async
  await SupabaseConfig.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Katinat App',
        theme: ThemeData(
          primaryColor: primaryColor,
          fontFamily: 'Roboto',
          // Thiết lập style mặc định cho các TextField.
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFBE9369), width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white24, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            hintStyle: const TextStyle(color: Colors.blueGrey),
          ),
        ),
        // Khởi động khi app chạy
        initialRoute: '/',
        routes: {
          '/': (context) => const MainLayout(),
          '/detail': (context) => const DetailPage(),
          '/cart': (context) => const CartPage(),
        },
      ),
    );
  }
}
