import 'package:flutter/material.dart';

const primaryColor = Color(0xFF023D50);
// ================= HOME PAGE =================
class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ProductCard(
            image:
            'https://images.unsplash.com/photo-1717398804998-ad2d48822518?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fG1hdGNoYSUyMGxhdHRlfGVufDB8fDB8fHww&auto=format&fit=crop&q=60&w=600',
            name: 'Matcha Latte',
            price: '45.000đ',
          ),
          ProductCard(
            image:
            'https://plus.unsplash.com/premium_photo-1677607237294-b041e4b57391?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fGNvZmZlZSUyMG1pbGt8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&q=60&w=600',
            name: 'Milk Coffee',
            price: '55.000đ',
          ),
          ProductCard(
            image:
            'https://images.unsplash.com/photo-1501199532894-9449c0a85a77?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8dHIlQzMlQTAlMjB0ciVDMyVBMWklMjBjJUMzJUEyeXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&q=60&w=600',
            name: 'Cóc Cóc Đác Đác',
            price: '60.000đ',
          ),
        ],
      ),
    );
  }
}

// ================= PRODUCT CARD =================
class ProductCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  const ProductCard({
    super.key,
    required this.image,
    required this.name,
    required this.price
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.brown.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius:
            const BorderRadius.horizontal(left: Radius.circular(12)),
            child: Image.network(
              image,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(price,
                    style: const TextStyle(
                        color: Colors.brown, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_shopping_cart),
            color: Colors.brown,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}