import 'package:extinct_animals/ui/view/home_view.dart';
import 'package:extinct_animals/ui/view_model/change_language_view_model.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _initConfig();
  }

  void _initConfig() async {
    final ChangeLanguageViewModel changeLanguageViewModel =
        ChangeLanguageViewModel.instance;
    await changeLanguageViewModel.modifyLanguageLabels();
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
