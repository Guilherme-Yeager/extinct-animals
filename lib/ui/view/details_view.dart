import 'package:extinct_animals/domain/models/animal_model.dart';
import 'package:extinct_animals/ui/view_model/change_language_view_model.dart';
import 'package:flutter/material.dart';
import 'package:extinct_animals/utils/constants/colors_custom.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsView extends StatefulWidget {
  final AnimalModel animal;
  final ChangeLanguageViewModel _changeLanguageViewModel =
      ChangeLanguageViewModel.instance;

  DetailsView({super.key, required this.animal});

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  bool _clickLink = false;

  @override
  Widget build(BuildContext context) {
    final String? nomeComum = widget.animal.commonName;
    final String nomeCientifico = widget.animal.binomialName;
    final String? descricao = widget.animal.shortDesc;
    final String wikiLink = widget.animal.wikiLink;
    final List<String> labels =
        widget._changeLanguageViewModel.getLabels('Details')!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => _clickLink ? null : Navigator.of(context).pop(),
        ),
        title: Text(labels[0]),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: ColorsCustom.main,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  labels[1],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  color: Colors.green.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.science,
                              color: Colors.white,
                              size: 24,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              labels[2],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 34.0, top: 4.0),
                          child: Text(
                            nomeCientifico,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Image.asset(
                              'assets/img/Kawaii Dinosaur.png',
                              width: 24,
                              height: 24,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              labels[3],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 34.0, top: 4.0),
                          child: Text(
                            nomeComum ?? '',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Icon(
                              Icons.description,
                              color: Colors.white,
                              size: 24,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              labels[4],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 34.0, top: 4.0),
                          child: Text(
                            descricao ?? '',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Icon(
                              Icons.insert_link,
                              color: Colors.white,
                              size: 24,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              labels[5],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 34.0, top: 4.0),
                          child: InkWell(
                            onTap:
                                _clickLink
                                    ? null
                                    : () async {
                                      setState(() {
                                        _clickLink = true;
                                      });
                                      ScaffoldFeatureController<
                                        SnackBar,
                                        SnackBarClosedReason
                                      >?
                                      snackBar;
                                      final Uri uri = Uri.parse(wikiLink);
                                      final success = await launchUrl(
                                        uri,
                                        mode: LaunchMode.platformDefault,
                                      );
                                      if (!success) {
                                        if (context.mounted) {
                                          snackBar = ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(content: Text(labels[6])),
                                          );
                                        }
                                      }
                                      if (snackBar != null) {
                                        await Future.delayed(
                                          const Duration(seconds: 1),
                                        );
                                        snackBar.close();
                                      }
                                      setState(() {
                                        _clickLink = false;
                                      });
                                    },
                            child: Text(
                              wikiLink,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
