import 'dart:ui';

import 'package:circular_linked_list/circular_linked_list.dart';
import 'package:extinct_animals/domain/models/animal_model.dart';
import 'package:extinct_animals/domain/models/language_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:translator/translator.dart';

class ChangeLanguageViewModel {
  final ValueNotifier<LanguageModel?> _languageModel =
      ValueNotifier<LanguageModel?>(null);
  static final ChangeLanguageViewModel _instance = ChangeLanguageViewModel._();
  final CircularLinkedList<LanguageModel> _languageModelList =
      CircularLinkedList<LanguageModel>();
  static ChangeLanguageViewModel get instance => _instance;
  ValueNotifier<LanguageModel?> get languageModel => _languageModel;

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

  Future<void> modifyLanguageData(AnimalModel? animalModel) async {
    if (animalModel != null) {
      // TODO: Modificar os dados do animal aqui
    }
  }

  Future<String> modifyLanguageText(String text) async {
    return (await text.translate(
      from: 'en',
      to: _languageModel.value!.languageCode.toLowerCase(),
    )).text;
  }
}
