import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String supabaseUrl = 'https://mhpmuelcubcdpqfrcvcs.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1ocG11ZWxjdWJjZHBxZnJjdmNzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDg2NDk0NjUsImV4cCI6MjA2NDIyNTQ2NX0.AaHkrb1N43Sp3i-pIcpDLg22XKseoJKBohc1jTsBMV8';

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}