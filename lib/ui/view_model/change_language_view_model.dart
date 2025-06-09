import 'dart:ui';

import 'package:circular_linked_list/circular_linked_list.dart';
import 'package:extinct_animals/domain/models/language_model.dart';
import 'package:flutter/cupertino.dart';

class ChangeLanguageViewModel {
  final ValueNotifier<String> _language = ValueNotifier<String>('');
  static final ChangeLanguageViewModel _instance = ChangeLanguageViewModel._();
  final CircularLinkedList<LanguageModel> _languageModel =
      CircularLinkedList<LanguageModel>();
  static ChangeLanguageViewModel get instance => _instance;

  ChangeLanguageViewModel._() {
    Set<String> countryCodes = {
      PlatformDispatcher.instance.locale.countryCode.toString(),
      'BR',
      'GF',
      'DE',
      'IT',
      'RU',
    };
    _languageModel.addAll(countryCodes.map((e) => LanguageModel(e)));
    _language.value = _languageModel.first.language;
  }

  ValueNotifier<String> get language => _language;

  void nextLanguage() {
    _languageModel.first.next!.setToHead();
    _language.value = _languageModel.first.language;
  }

  void backLanguage() {
    _languageModel.first.previous!.setToHead();
    _language.value = _languageModel.first.language;
  }
}
