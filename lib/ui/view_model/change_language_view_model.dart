import 'package:flutter/cupertino.dart';

class ChangeLanguageViewModel {
  final ValueNotifier<String> _language = ValueNotifier<String>('pt');
  static final ChangeLanguageViewModel _instance = ChangeLanguageViewModel._();

  ChangeLanguageViewModel._();

  ValueNotifier<String> get language => _language;

  void setLanguage(String language) {
    _language.value = language;
  }

  static ChangeLanguageViewModel get instance => _instance;
}
