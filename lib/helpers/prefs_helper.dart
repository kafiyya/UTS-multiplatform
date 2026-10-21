import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper {
  static const String _nameKey = 'user_name';
  static const String _roleKey = 'user_role';

  // Menyimpan nama dan peran (Admin atau Peminjam)
  static Future<void> saveUser(String name, String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, name);
    await prefs.setString(_roleKey, role);
  }

  // Mengambil nama dan peran
  static Future<Map<String, String?>> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString(_nameKey),
      'role': prefs.getString(_roleKey),
    };
  }

  // Menghapus sesi saat logout
  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_nameKey);
    await prefs.remove(_roleKey);
  }
}