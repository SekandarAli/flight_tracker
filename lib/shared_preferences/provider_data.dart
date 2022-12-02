import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderData with ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  late String _settingName;
  String get settingName => _settingName;

  void _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('current_index', _currentIndex);
    prefs.setString('setting_name', _settingName);
    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentIndex = prefs.getInt('current_index') ?? 0;
    _settingName = prefs.getString('setting_name') ?? "0";
    notifyListeners();
  }
}
