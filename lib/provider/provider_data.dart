import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderData with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  // double _totalPrice = 0.0;
  //
  // double get totalPrice => _totalPrice;


  void _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('current_index', _currentIndex);
    // prefs.setDouble('total_price', _totalPrice);

    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentIndex = prefs.getInt('current_index') ?? 0;
    // _totalPrice = prefs.getDouble('total_price') ?? 0.0;
    notifyListeners();
  }

  // void addCounter() {
  //   if (_currentIndex >= 0) {
  //     _currentIndex = _currentIndex + 1;
  //     _setPrefItems();
  //     notifyListeners();
  //   } else {}
  // }
  //
  // void removerCounter() {
  //   if (_currentIndex > 0) {
  //     _currentIndex = _currentIndex - 1;
  //     _setPrefItems();
  //     notifyListeners();
  //   } else {}
  // }
  //
  // int getCounter() {
  //   _getPrefItems();
  //   return _currentIndex;
  // }

  //
  // void addTotalPrice(double salePrice) {
  //   _totalPrice = _totalPrice + salePrice;
  //   _setPrefItems();
  //   notifyListeners();
  // }
  //
  // void removeTotalPrice(double salePrice) {
  //   _totalPrice = _totalPrice - salePrice;
  //   _setPrefItems();
  //   notifyListeners();
  // }
  //
  // double getTotalPrice() {
  //   _getPrefItems();
  //   return _totalPrice;
  // }

}
