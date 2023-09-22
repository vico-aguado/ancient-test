import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  late SharedPreferences preferences;

  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<bool> saveTheme(bool isDark) async {
    return await preferences.setBool('isDark', isDark);
  }

  bool? getTheme() {
    return preferences.getBool('isDark');
  }

  Future<void> clear() async {
    await preferences.clear();
  }
}

final preferences = Preferences();
