import 'package:flutter/cupertino.dart';

class ChangeLanguageViewModel extends ChangeNotifier {
  String _language = 'pt';
  static final ChangeLanguageViewModel _instance = ChangeLanguageViewModel._();

  ChangeLanguageViewModel._();

  String get language => _language;

  void setLanguage(String language) {
    _language = language;
    notifyListeners();
  }

  static ChangeLanguageViewModel get instance {
    return _instance;
  }
}
