import 'dart:async';

import 'package:extinct_animals/ui/view/home_view.dart';
import 'package:extinct_animals/ui/view_model/change_language_view_model.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/colors_custom.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

// class _SplashViewState extends State<SplashView> {
//   @override
//   void initState() {
//     super.initState();
//     _initConfig();
//   }

//   void _initConfig() async {
//     final ChangeLanguageViewModel changeLanguageViewModel =
//         ChangeLanguageViewModel.instance;
//     await changeLanguageViewModel.modifyLanguageLabels();
//     if (mounted) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HomeView()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }


class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () async {
      final ChangeLanguageViewModel changeLanguageViewModel =
          ChangeLanguageViewModel.instance;
      await changeLanguageViewModel.modifyLanguageLabels();
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeView()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorsCustom.main,
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: widthScreen * 0.1, end: widthScreen * 0.6),
          duration: const Duration(seconds: 2),
          curve: Curves.easeOut,
          builder: (context, size, child) {
            return SizedBox(
              width: size,
              child: Image.asset(
                'assets/img/T-Rex.png',
                //width: size,
                fit: BoxFit.contain,
              ),
            );
          },
        ),
      ),
    );
  }
}
