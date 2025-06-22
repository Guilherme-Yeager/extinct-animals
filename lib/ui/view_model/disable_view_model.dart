import 'package:flutter/cupertino.dart';

class DisableViewModel {
  final ValueNotifier<Map<String, bool>> _screens =
      ValueNotifier<Map<String, bool>>({'Home': false});

  ValueNotifier<Map> get screens => _screens;

  void addScreens(List<String> screens) {
    for (String screen in screens) {
      _screens.value[screen] = true;
    }
  }

  void enableScreen(String screen) {
    _screens.value[screen] = false;
  }

  void disabledScreen(String screen) {
    _screens.value[screen] = true;
  }
}
