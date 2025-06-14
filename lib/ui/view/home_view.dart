import 'package:extinct_animals/ui/view/details_view.dart';
import 'package:extinct_animals/ui/view_model/change_language_view_model.dart';
import 'package:extinct_animals/ui/view_model/extinct_animal_view_model.dart';
import 'package:extinct_animals/utils/shared/change_language_custom.dart';
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
  bool _isLoading = false;

  String _appBarTitle = 'Animails extintos';
  String _buttonText = 'Novo';
  String _detailsText = 'Detailhes';

  @override
  void initState() {
    super.initState();
    _changeLanguageViewModel.languageModel.addListener(_loadText);
    _extinctAnimalViewModel.animalModel.addListener(
      () => setState(() {
        _isLoading = !_isLoading;
      }),
    );
  }

  Future<void> _loadText() async {
    final String viewTexts = await _changeLanguageViewModel.modifyLanguageText(
      'Extinct animals; Details; New',
    );
    setState(() {
      final List<String> splitText = viewTexts.split(';');
      _appBarTitle = splitText[0];
      _detailsText = splitText[1];
      _buttonText = splitText[2];
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
      appBar: AppBar(title: Text(_appBarTitle), centerTitle: true),
      backgroundColor: ColorsCustom.main,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 10,
                  bottom: 10,
                ),
                child: ChangeLanguageCustom(
                  extinctAnimalViewModel: _extinctAnimalViewModel,
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      if (imageSrc != null) ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(
                            imageSrc,
                            loadingBuilder: (context, child, _) {
                              return child;
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return errorImage();
                            },
                            width: double.infinity,
                            height: 250,
                            fit: BoxFit.fill,
                            semanticLabel: 'Animal Extinct',
                          ),
                        ),
                      ] else ...[
                        errorImage(),
                        SizedBox(height: 15),
                      ],
                      if (location != null) ...[
                        SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            final currentAnimal =
                                _extinctAnimalViewModel.animalModel.value;
                            if (currentAnimal != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder:
                                      (BuildContext context) => DetailsView(
                                        animal: currentAnimal,
                                      ), // Passa o animal
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Nenhum animal carregado para detalhes.',
                                  ),
                                ),
                              );
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.info_outline,
                                size: 26,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5),
                              Text(
                                _detailsText,
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
                        onPressed: () async {
                          setState(() {
                            _isLoading = !_isLoading;
                          });
                          await _extinctAnimalViewModel.newRandomAnimal();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        child:
                            _isLoading
                                ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                    strokeWidth: 2.5,
                                  ),
                                )
                                : Text(
                                  _buttonText,
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
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget errorImage() {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Icon(Icons.image_not_supported, size: 60, color: Colors.grey[700]),
    );
  }
}
