// auth_service.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:my_app/supabase_config.dart';

// Đăng nhập, đăng ký, đăng xuất, reset password
class AuthService {
  final SupabaseClient _supabase = SupabaseConfig.client;
  // SupabaseConfig.client là client đã được khởi tạo sẵn trong supabase_config.dart.



  // Đăng ký với email
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Đăng nhập với email
  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Gửi email reset password
  Future<void> resetPassword({required String email}) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } catch (e) {
      rethrow;
    }
  }

  // Đăng xuất
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  // Lấy user hiện tại
  User? get currentUser => _supabase.auth.currentUser;

  // Kiểm tra đã đăng nhập chưa
  bool get isAuthenticated => currentUser != null;

  // Lắng nghe thay đổi auth state
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;
}