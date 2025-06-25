import 'package:extinct_animals/domain/models/animal_model.dart';
import 'package:extinct_animals/ui/view/details_view.dart';
import 'package:extinct_animals/ui/view/favorites_view.dart';
import 'package:extinct_animals/ui/view_model/change_language_view_model.dart';
import 'package:extinct_animals/ui/view_model/disable_view_model.dart';
import 'package:extinct_animals/ui/view_model/extinct_animal_view_model.dart';
import 'package:extinct_animals/ui/view_model/shared_preferences_view_model.dart';
import 'package:extinct_animals/utils/shared/error_image_custom.dart';
import 'package:flutter/material.dart';
import 'package:extinct_animals/utils/constants/colors_custom.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ChangeLanguageViewModel _changeLanguageViewModel =
      ChangeLanguageViewModel.instance;
  final ExtinctAnimalViewModel _extinctAnimalViewModel =
      ExtinctAnimalViewModel();
  final DisableViewModel _disableViewModel = DisableViewModel();
  final SharedPreferencesViewModel _sharedPreferencesViewModel =
      SharedPreferencesViewModel();

  late List<String> _labels;
  bool _isFavorite = false, _isSaving = false, _isGallery = false;

  @override
  void initState() {
    super.initState();
    _labels = _changeLanguageViewModel.getLabels('Home')!;
    _changeLanguageViewModel.languageModel.addListener(_loadText);
    _extinctAnimalViewModel.animalModel.addListener(() => setState(() {}));
    _disableViewModel.screens.addListener(() => setState(() {}));
  }

  void _checkIsFavorite() {
    bool isFavorite = false;
    if (_extinctAnimalViewModel.animalModel.value != null) {
      if (_sharedPreferencesViewModel.getAnimal(
            _extinctAnimalViewModel.animalModel.value!.binomialName,
          ) !=
          null) {
        isFavorite = true;
      } else {
        isFavorite = false;
      }
    }
    setState(() {
      _isFavorite = isFavorite;
    });
  }

  Future<void> _loadText() async {
    await _changeLanguageViewModel.modifyLanguageLabels();
    setState(() {
      _labels = _changeLanguageViewModel.getLabels('Home')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String? commonName =
        _extinctAnimalViewModel.animalModel.value?.commonName;
    final String? imageSrc =
        _extinctAnimalViewModel.animalModel.value?.imageSrc;
    final String? location =
        _extinctAnimalViewModel.animalModel.value?.location;
    return Scaffold(
      appBar: AppBar(title: Text(_labels[0]), centerTitle: true),
      backgroundColor: ColorsCustom.main,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed:
                        _disableViewModel.screens.value['Home']
                            ? null
                            : () async {
                              _changeLanguageViewModel.backLanguage();
                              setState(() {
                                _disableViewModel.disabledScreen('Home');
                              });
                              await _loadText();
                              _disableViewModel.enableScreen('Home');
                            },
                    icon: Icon(Icons.chevron_left, color: Colors.white),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                  Container(
                    width: 50,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'icons/flags/png100px/${_changeLanguageViewModel.languageModel.value!.countyrCode}.png',
                      package: 'country_icons',
                      fit: BoxFit.contain,
                      width: 40,
                      height: 40,
                    ),
                  ),
                  IconButton(
                    onPressed:
                        _disableViewModel.screens.value['Home']
                            ? null
                            : () async {
                              _changeLanguageViewModel.nextLanguage();
                              setState(() {
                                _disableViewModel.disabledScreen('Home');
                              });
                              await _loadText();
                              _disableViewModel.enableScreen('Home');
                            },
                    icon: Icon(Icons.chevron_right, color: Colors.white),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                  Expanded(child: Container()),
                  TextButton(
                    onPressed:
                        _isGallery || _disableViewModel.screens.value['Home']
                            ? null
                            : () async {
                              setState(() {
                                _isGallery = true;
                              });
                              List<AnimalModel> animals =
                                  await _sharedPreferencesViewModel
                                      .getAllAnimals();
                              ScaffoldFeatureController<
                                SnackBar,
                                SnackBarClosedReason
                              >?
                              snackBar;
                              if (animals.isEmpty) {
                                if (context.mounted) {
                                  snackBar = ScaffoldMessenger.of(
                                    context,
                                  ).showSnackBar(
                                    SnackBar(
                                      content: Text(_labels[4]),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              } else if (context.mounted) {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder:
                                        (BuildContext context) =>
                                            FavoritesView(animals: animals),
                                  ),
                                );
                                _checkIsFavorite();
                              }
                              if (snackBar != null) {
                                await snackBar.closed;
                              }
                              setState(() {
                                _isGallery = false;
                              });
                            },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.photo_library, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          _labels[3],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Opacity(
                          opacity: commonName != null ? 1 : 0,
                          child: Text(
                            commonName ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 15),
                        if (imageSrc != null &&
                            !imageSrc.contains("Sem imagem")) ...[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child:
                                _disableViewModel.screens.value['Home']
                                    ? SizedBox(
                                      width: 200,
                                      height: 200,
                                      child: Center(
                                        child: LinearProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                    : Image.network(
                                      imageSrc,
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        return ErrorImageCustom.errorImage();
                                      },
                                      width: double.infinity,
                                      height: 250,
                                      fit: BoxFit.fill,
                                    ),
                          ),
                        ] else ...[
                          ErrorImageCustom.errorImage(),
                          SizedBox(height: 15),
                        ],
                        if (location != null) ...[
                          SizedBox(height: 10),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(child: Container()),
                              SizedBox(width: 30),
                              TextButton(
                                onPressed: () {
                                  final currentAnimal =
                                      _extinctAnimalViewModel.animalModel.value;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder:
                                          (BuildContext context) => DetailsView(
                                            animal: currentAnimal!,
                                          ),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      Icons.info_outline,
                                      size: 26,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      _labels[1],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(child: Container()),
                              IconButton(
                                onPressed:
                                    _isSaving ||
                                            _disableViewModel
                                                .screens
                                                .value['Home']
                                        ? null
                                        : () async {
                                          setState(() {
                                            _isSaving = true;
                                            _isFavorite = !_isFavorite;
                                          });
                                          if (_isFavorite) {
                                            _sharedPreferencesViewModel
                                                .saveAnimal(
                                                  _extinctAnimalViewModel
                                                      .animalModel
                                                      .value!,
                                                );
                                          } else {
                                            await _sharedPreferencesViewModel
                                                .removeAnimal(
                                                  _extinctAnimalViewModel
                                                      .animalModel
                                                      .value!
                                                      .binomialName,
                                                );
                                          }
                                          _checkIsFavorite();
                                          setState(() {
                                            _isSaving = false;
                                          });
                                        },
                                icon: Icon(
                                  _isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                size: 26,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  _extinctAnimalViewModel
                                      .animalModel
                                      .value!
                                      .location,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.calendar_today,
                                size: 26,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5),
                              Text(
                                _extinctAnimalViewModel
                                    .animalModel
                                    .value!
                                    .lastRecord,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                                softWrap: true,
                              ),
                            ],
                          ),
                        ],
                        SizedBox(height: 35),
                        ElevatedButton(
                          onPressed:
                              _disableViewModel.screens.value['Home']
                                  ? null
                                  : () async {
                                    setState(() {
                                      _disableViewModel.disabledScreen('Home');
                                    });
                                    await _extinctAnimalViewModel
                                        .getRandomAnimal();
                                    _disableViewModel.enableScreen('Home');
                                    _changeLanguageViewModel
                                        .modifyLanguageLabels();
                                    setState(() {
                                      _checkIsFavorite();
                                    });
                                  },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            disabledBackgroundColor: Colors.white,
                            overlayColor: Colors.green,
                          ),
                          child:
                              _disableViewModel.screens.value['Home']
                                  ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                    ),
                                  )
                                  : Text(
                                    _labels[2],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.visible,
                                    softWrap: false,
                                  ),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
