import 'package:flutter/foundation.dart';

class ThemeNotifier extends ChangeNotifier {
  bool isNotificationfound = false;
  bool gettingNotification() => isNotificationfound;

  void updateTheme(bool isNotificationfound) async {
    this.isNotificationfound = isNotificationfound;
    notifyListeners();
  }
}
