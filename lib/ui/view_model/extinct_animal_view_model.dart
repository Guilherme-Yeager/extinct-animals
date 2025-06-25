import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:extinct_animals/data/services/extinct_service.dart';
import 'package:extinct_animals/domain/models/animal_model.dart';

class ExtinctAnimalViewModel {
  final ValueNotifier<AnimalModel?> _animalModel = ValueNotifier<AnimalModel?>(
    null,
  );
  final ExtinctService _animalService = ExtinctService();

  ValueNotifier<AnimalModel?> get animalModel => _animalModel;

  Future<void> getRandomAnimal() async {
    int id = Random().nextInt(804) + 1;
    final Map<String, dynamic>? data = await _animalService.getRandomAnimal(id);
    if (data != null) {
      String commonName = data['data'][0]['commonName'];
      String imageSrc = data['data'][0]['imageSrc'];
      String shortDesc = data['data'][0]['shortDesc'];
      _animalModel.value = AnimalModel(
        id: id,
        commonName: commonName == 'false' ? 'Sem nome comun' : commonName,
        binomialName: data['data'][0]['binomialName'],
        location: data['data'][0]['location'],
        wikiLink:
            shortDesc == 'false' ? 'Sem wiki' : data['data'][0]['wikiLink'],
        lastRecord: data['data'][0]['lastRecord'],
        imageSrc: imageSrc == 'false' ? 'Sem imagem' : imageSrc,
        shortDesc: shortDesc == 'false' ? 'Sem descrição' : shortDesc,
      );
      return;
    }
    _animalModel.value = null;
  }
}
