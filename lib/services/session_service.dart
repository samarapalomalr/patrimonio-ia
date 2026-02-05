import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static const _loggedKey = 'logged';
  static const _loginTypeKey = 'login_type';
  static const _usernameKey = 'username';

  /// Login local (usuário + senha)
  static Future<void> saveLocalUser(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedKey, true);
    await prefs.setString(_loginTypeKey, 'local');
    await prefs.setString(_usernameKey, username);
  }

  /// Login via Google (Firebase)
  static Future<void> saveFirebaseUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedKey, true);
    await prefs.setString(_loginTypeKey, 'google');
  }

  /// Verifica se existe sessão ativa
  static Future<bool> isLogged() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loggedKey) ?? false;
  }

  /// Retorna tipo de login: local | google
  static Future<String?> loginType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_loginTypeKey);
  }

  /// Retorna usuário do login local
  static Future<String?> getLocalUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  /// Logout geral (limpa toda a sessão)
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  /// Alias usado pela HomeScreen
  static Future<void> clear() async {
    await logout();
  }
}
