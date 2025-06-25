import 'package:extinct_animals/domain/models/animal_model.dart';
import 'package:extinct_animals/ui/view/details_view.dart';
import 'package:extinct_animals/ui/view_model/change_language_view_model.dart';
import 'package:extinct_animals/ui/view_model/shared_preferences_view_model.dart';
import 'package:extinct_animals/utils/shared/app_bar_custom.dart';
import 'package:extinct_animals/utils/shared/error_image_custom.dart';
import 'package:flutter/material.dart';
import 'package:extinct_animals/utils/constants/colors_custom.dart';

class FavoritesView extends StatefulWidget {
  final List<AnimalModel> animals;

  const FavoritesView({super.key, required this.animals});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  final List<String>? _labels = ChangeLanguageViewModel.instance.getLabels(
    'Favorites',
  );
  final SharedPreferencesViewModel _sharedPreferencesViewModel =
      SharedPreferencesViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom.buildAppBar(context, _labels![0]),
      backgroundColor: ColorsCustom.main,
      body: PageView(
        children:
            widget.animals.map((animal) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Opacity(
                      opacity: animal.commonName != null ? 1 : 0,
                      child: Text(
                        animal.commonName ?? '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 15),
                    if (animal.imageSrc != null &&
                        !animal.imageSrc!.contains("Sem imagem"))
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          animal.imageSrc!,
                          errorBuilder: (context, error, stackTrace) {
                            return ErrorImageCustom.errorImage();
                          },
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.fill,
                        ),
                      )
                    else
                      ErrorImageCustom.errorImage(),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(child: Container()),
                        SizedBox(width: 30),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder:
                                    (BuildContext context) =>
                                        DetailsView(animal: animal),
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
                          onPressed: () async {
                            await _sharedPreferencesViewModel.removeAnimal(
                              animal.id.toString(),
                            );
                            setState(() {
                              widget.animals.remove(animal);
                            });
                            if (widget.animals.isEmpty) {
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            }
                          },
                          icon: Icon(Icons.favorite, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: <Widget>[
                        Icon(Icons.location_on, size: 26, color: Colors.white),
                        SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            animal.location,
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
                          animal.lastRecord,
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
                    SizedBox(height: 15),
                  ],
                ),
              );
            }).toList(),
      ),
    );
  }
}
