import 'dart:ui';

import 'package:circular_linked_list/circular_linked_list.dart';
import 'package:extinct_animals/domain/models/language_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:translator/translator.dart';

class ChangeLanguageViewModel {
  final ValueNotifier<LanguageModel?> _languageModel =
      ValueNotifier<LanguageModel?>(null);
  ValueNotifier<LanguageModel?> get languageModel => _languageModel;

  static final ChangeLanguageViewModel _instance = ChangeLanguageViewModel._();
  static ChangeLanguageViewModel get instance => _instance;

  final CircularLinkedList<LanguageModel> _languageModelList =
      CircularLinkedList<LanguageModel>();

  final Map<String, List<String>> _labels = {
    'Home': [''],
    'Details': [''],
    'Favorites': [''],
  };

  List<String>? getLabels(String screen) {
    return _labels[screen];
  }

  final String _textBase =
      'Extinct animals; Details; New; Back; Name; Scientific Name; Short Description; Link; Could not open link; Favorites; No favorites';

  ChangeLanguageViewModel._() {
    final Map<String, String> codes = {
      'br': 'pt', // Brasil
      'us': 'en', // Estados Unidos
      'gf': 'fr', // França
      'de': 'de', // Alemanha
      'it': 'it', // Itália
      'ru': 'ru', // Rússia
    };
    final String currentCountryCode =
        PlatformDispatcher.instance.locale.countryCode.toString().toLowerCase();
    final String currentlanguageCode =
        PlatformDispatcher.instance.locale.languageCode
            .toString()
            .toLowerCase();
    if (!codes.containsKey(currentCountryCode)) {
      codes[currentCountryCode] = currentlanguageCode;
    }
    _languageModelList.addAll(
      codes.keys.map(
        (chave) =>
            LanguageModel(countyrCode: chave, languageCode: codes[chave]!),
      ),
    );
    _languageModel.value = _languageModelList.first;
  }

  void nextLanguage() {
    _languageModelList.first.next!.setToHead();
    _languageModel.value = _languageModelList.first;
  }

  void backLanguage() {
    _languageModelList.first.previous!.setToHead();
    _languageModel.value = _languageModelList.first;
  }

  Future<void> modifyLanguageLabels() async {
    List<String> words = (await _textBase.translate(
      from: 'en',
      to: _languageModel.value!.languageCode,
    )).text.split(';');
    _labels['Home'] = [words[0], words[1], words[2], words[9], words[10]];
    _labels['Details'] = [
      words[3],
      words[1],
      words[4],
      words[5],
      words[6],
      words[7],
      words[8],
    ];
    _labels['Favorites'] = [words[3], words[1]];
    return;
  }
}
