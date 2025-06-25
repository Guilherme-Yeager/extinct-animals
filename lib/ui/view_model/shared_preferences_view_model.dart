import 'dart:convert';

import 'package:extinct_animals/domain/models/animal_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesViewModel {
  late SharedPreferences _prefs;

  SharedPreferencesViewModel() {
    _loadSharedPreferences();
  }

  Future<void> _loadSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> saveAnimal(AnimalModel animalModel) async {
    return await _prefs.setString(
      '${animalModel.binomialName}Animal',
      jsonEncode(animalModel),
    );
  }

  String? getAnimal(String id) {
    return _prefs.getString('${id}Animal');
  }

  Future<List<AnimalModel>> getAllAnimals() async {
    final Set<String> keys = _prefs.getKeys();
    final List<AnimalModel> animals = <AnimalModel>[];
    for (String key in keys) {
      if (!key.contains('Animal')) {
        continue;
      }
      final String? jsonString = _prefs.getString(key);
      if (jsonString != null) {
        final dynamic jsonMap = jsonDecode(jsonString);
        animals.add(AnimalModel.fromJson(jsonMap));
      }
    }
    return animals;
  }

  Future<bool> removeAnimal(String id) async {
    return await _prefs.remove('${id}Animal');
  }
}
