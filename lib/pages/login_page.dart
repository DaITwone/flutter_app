import 'package:flutter/material.dart';
import 'package:my_app/main_layout.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:my_app/services/auth_service.dart';

const primaryColor = Color(0xFF023D50);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogin = true;
  bool isLoading = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isPasswordVisible = false;

  final AuthService _authService = AuthService();

  bool get isFormValid {
    if (isLogin) {
      return emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty;
    } else {
      return emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty &&
          passwordController.text == confirmPasswordController.text;
    }
  }

  // Validate email
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Hiển thị thông báo
  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // Hiển thị dialog reset password
  void _showResetPasswordDialog() {
    final TextEditingController resetEmailController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Quên mật khẩu'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Nhập email để nhận link đặt lại mật khẩu'),
            const SizedBox(height: 16),
            TextField(
              controller: resetEmailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (!isValidEmail(resetEmailController.text)) {
                if (mounted) {
                  _showMessage('Email không hợp lệ', isError: true);
                }
                return;
              }

              try {
                await _authService.resetPassword(
                  email: resetEmailController.text.trim(),
                );
                if (dialogContext.mounted) {
                  Navigator.pop(dialogContext);
                }
                if (mounted) {
                  _showMessage(
                    'Link đặt lại mật khẩu đã được gửi đến email của bạn',
                  );
                }
              } catch (e) {
                if (mounted) {
                  _showMessage('Lỗi: ${e.toString()}', isError: true);
                }
              }
            },
            child: const Text('Gửi'),
          ),
        ],
      ),
    );
  }

  // Xử lý đăng ký
  Future<void> _handleSignUp() async {
    if (!isFormValid) {
      _showMessage('Vui lòng điền đầy đủ thông tin', isError: true);
      return;
    }

    if (!isValidEmail(emailController.text)) {
      _showMessage('Email không hợp lệ', isError: true);
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      _showMessage('Mật khẩu xác nhận không khớp', isError: true);
      return;
    }

    if (passwordController.text.length < 6) {
      _showMessage('Mật khẩu phải có ít nhất 6 ký tự', isError: true);
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await _authService.signUpWithEmail(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (response.user != null) {
        _showMessage(
          'Đăng ký thành công! Vui lòng kiểm tra email để xác thực tài khoản.',
        );
        // Chuyển về tab đăng nhập
        setState(() {
          isLogin = true;
          emailController.clear();
          passwordController.clear();
          confirmPasswordController.clear();
        });
      }
    } catch (e) {
      String errorMessage = 'Lỗi đăng ký';
      if (e.toString().contains('already registered')) {
        errorMessage = 'Email này đã được đăng ký';
      }
      _showMessage(errorMessage, isError: true);
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  // Xử lý đăng nhập
  Future<void> _handleSignIn() async {
    if (!isFormValid) {
      _showMessage('Vui lòng điền đầy đủ thông tin', isError: true);
      return;
    }

    if (!isValidEmail(emailController.text)) {
      _showMessage('Email không hợp lệ', isError: true);
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await _authService.signInWithEmail(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (response.user != null) {
        _showMessage('Đăng nhập thành công!');
        // Chuyển sang màn hình chính
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MainLayout(child: HomePage()),
            ),
          );
        }
      }
    } catch (e) {
      String errorMessage = 'Lỗi đăng nhập';
      if (e.toString().contains('Invalid login credentials')) {
        errorMessage = 'Email hoặc mật khẩu không đúng';
      } else if (e.toString().contains('Email not confirmed')) {
        errorMessage = 'Vui lòng xác thực email trước khi đăng nhập';
      }
      _showMessage(errorMessage, isError: true);
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo Katinat
                Center(
                  child: Image.asset('assets/images/logo.png', height: 250),
                ),
                // Đăng ký/ Đăng nhập
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                setState(() {
                                  isLogin = false;
                                  confirmPasswordController.clear();
                                });
                              },
                        child: Text(
                          'ĐĂNG KÝ',
                          style: TextStyle(
                            color: isLogin
                                ? Colors.white54
                                : const Color.fromARGB(225, 207, 171, 92),
                            fontWeight: isLogin
                                ? FontWeight.normal
                                : FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                setState(() {
                                  isLogin = true;
                                });
                              },
                        child: Text(
                          'ĐĂNG NHẬP',
                          style: TextStyle(
                            color: isLogin
                                ? const Color.fromARGB(225, 207, 171, 92)
                                : Colors.white54,
                            fontWeight: isLogin
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  isLogin
                      ? 'Chào mừng bạn đã quay trở lại!'
                      : 'Tạo tài khoản mới để bắt đầu',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                  enabled: !isLoading,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white10,
                    prefixIcon: Icon(Icons.email, color: Colors.white54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: !isPasswordVisible,
                  style: const TextStyle(color: Colors.white),
                  enabled: !isLoading,
                  decoration: InputDecoration(
                    hintText: 'Mật khẩu',
                    hintStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white10,
                    prefixIcon: const Icon(Icons.lock, color: Colors.white54),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white70,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                if (!isLogin) ...[
                  const SizedBox(height: 16),
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    enabled: !isLoading,
                    decoration: const InputDecoration(
                      hintText: 'Xác nhận mật khẩu',
                      hintStyle: TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.white10,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Colors.white54,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ],
                const SizedBox(height: 8),
                if (isLogin)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: isLoading ? null : _showResetPasswordDialog,
                      child: const Text(
                        'Quên mật khẩu?',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : (isFormValid
                              ? (isLogin ? _handleSignIn : _handleSignUp)
                              : null),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(225, 207, 171, 92),
                      disabledBackgroundColor: Colors.white24,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Text(
                            isLogin ? 'Đăng nhập' : 'Đăng ký',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
