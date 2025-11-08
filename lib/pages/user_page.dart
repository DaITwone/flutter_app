// user_page.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_app/main_layout.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:my_app/pages/login_page.dart';
import 'package:my_app/services/auth_service.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _authService = AuthService();
  String userName = 'Người dùng';
  String userAvatar = 'KAT';
  int katPoints = 0;
  bool _isExpanded = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkAuthAndLoadData();
  }

  Future<void> _checkAuthAndLoadData() async {
    // Kiểm tra xem đã đăng nhập chưa
    if (!_authService.isAuthenticated) {
      // Nếu chưa đăng nhập, chuyển đến trang login
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainLayout(child: LoginPage())),
        );
      }
      return;
    }

    // Nếu đã đăng nhập, load dữ liệu người dùng
    await _loadUserData();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _loadUserData() async {
    final user = _authService.currentUser;
    
    if (user != null) {
      setState(() {
        // Lấy tên từ user metadata hoặc email
        if (user.userMetadata?['full_name'] != null) {
          userName = user.userMetadata!['full_name'];
        } else if (user.userMetadata?['name'] != null) {
          userName = user.userMetadata!['name'];
        } else {
          userName = user.email?.split('@')[0] ?? 'Người dùng';
        }
        
        // Tạo avatar từ chữ cái đầu của tên
        userAvatar = _getInitials(userName);
        
        // Có thể load KAT points từ database nếu có
        katPoints = 0;
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

  Future<void> _handleLogout() async {
    // Hiển thị dialog xác nhận
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Xác nhận đăng xuất',
          style: TextStyle(
            color: Color(0xFF023D50),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text('Bạn có chắc chắn muốn đăng xuất?'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(
              'Hủy',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(
              'Đăng xuất',
              style: TextStyle(color: Color(0xFFBE9369)),
            ),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    // Hiển thị loading
    if (mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(
            color: Color(0xFFBE9369),
          ),
        ),
      );
    }

    try {
      // Gọi signOut từ AuthService
      await _authService.signOut();
      
      if (mounted) {
        // Đóng loading dialog
        Navigator.of(context).pop();
        
        // Chuyển về trang home
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MainLayout(child: HomePage())),
          (route) => false,
        );
        
        // Hiển thị thông báo thành công
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đã đăng xuất thành công'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        // Đóng loading dialog
        Navigator.of(context).pop();
        
        // Hiển thị lỗi
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi đăng xuất: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFFBE9369),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          userName,
          style: const TextStyle(
            color: Color(0xFF023D50),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _handleLogout,
            child: const Text(
              'Đăng xuất',
              style: TextStyle(
                color: Color(0xFFBE9369),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Member Card Section
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFD4C5F9), Color(0xFFC9D6FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white.withOpacity(0.3),
                        child: Text(
                          userAvatar,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'NEW MEMBER',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5B4B8A),
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$katPoints KAT',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF5B4B8A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    '(KAT khả dụng)',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF7B6BA8),
                    ),
                  ),
                  const SizedBox(height: 80),
                  Text(
                    userName.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5B4B8A),
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),

            // Account Information Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Thông tin tài khoản',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF023D50),
                            ),
                          ),
                          Icon(
                            _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            color: const Color(0xFF023D50),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_isExpanded) ...[
                    const Divider(height: 1),
                    _buildMenuGrid(),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 16),

            // KAT Points Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$katPoints KAT',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF023D50),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: katPoints / 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFBE9369),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Cần thêm 100 KAT để lên hạng SILVER',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '* Cần phát sinh tối thiểu 01 đơn hàng trong 03 tháng để giữ hạng',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '* 1 KAT = 10.000VND',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Other Menu Items
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildMenuItem(Icons.card_giftcard, 'Đổi KAT'),
                  _buildDivider(),
                  _buildMenuItem(Icons.credit_card, 'Quản lý thẻ ATM/Credit Card'),
                  _buildDivider(),
                  _buildMenuItem(Icons.history, 'Lịch sử điểm'),
                  _buildDivider(),
                  _buildMenuItem(Icons.location_on, 'Địa chỉ đã lưu'),
                  _buildDivider(),
                  _buildMenuItem(Icons.home_work, 'Về chúng tôi'),
                  _buildDivider(),
                  _buildMenuItem(Icons.settings, 'Cài đặt'),
                  _buildDivider(),
                  _buildMenuItem(Icons.help_outline, 'Trợ giúp & Liên hệ'),
                  _buildDivider(),
                  _buildMenuItem(Icons.description, 'Điều khoản & Chính sách'),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuGrid() {
    final menuItems = [
      {'icon': Icons.edit, 'label': 'Chỉnh sửa\ntrang cá nhân'},
      {'icon': Icons.local_cafe, 'label': 'Gu của bạn'},
      {'icon': Icons.favorite_border, 'label': 'Danh sách\nyêu thích'},
      {'icon': Icons.emoji_events, 'label': 'Đặc quyền\nhạng thành viên'},
      {'icon': Icons.local_offer, 'label': 'Ưu đãi'},
      {'icon': Icons.access_time, 'label': 'Lịch sử\nđặt hàng'},
      {'icon': Icons.rate_review, 'label': 'Đánh giá\nđơn hàng'},
      {'icon': Icons.groups, 'label': 'Giới thiệu\nbạn bè'},
    ];

    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 16,
          crossAxisSpacing: 8,
          childAspectRatio: 0.85,
        ),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return GestureDetector(
            onTap: () {
              // Handle menu item tap
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF023D50).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: const Color(0xFF023D50),
                    size: 24,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item['label'] as String,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF023D50),
                    height: 1.2,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF023D50).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF023D50),
          size: 24,
        ),
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Color(0xFF023D50),
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.grey,
      ),
      onTap: () {
        // Handle menu item tap
      },
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      indent: 16,
      endIndent: 16,
    );
  }
}