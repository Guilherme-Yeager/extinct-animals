import 'package:extinct_animals/ui/view_model/change_language_view_model.dart';
import 'package:flutter/material.dart';

class ChangeLanguageCustom extends StatefulWidget {
  const ChangeLanguageCustom({super.key});

  @override
  State<ChangeLanguageCustom> createState() => _ChangeLanguageCustomState();
}

class _ChangeLanguageCustomState extends State<ChangeLanguageCustom> {
  final ChangeLanguageViewModel _changeLanguageViewModel =
      ChangeLanguageViewModel.instance;

  @override
  void initState() {
    super.initState();
    _changeLanguageViewModel.language.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: _changeLanguageViewModel.backLanguage,
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
            'icons/flags/png100px/${_changeLanguageViewModel.language.value}.png',
            package: 'country_icons',
            fit: BoxFit.contain,
            width: 40,
            height: 40,
          ),
        ),
        IconButton(
          onPressed: _changeLanguageViewModel.nextLanguage,
          icon: Icon(Icons.chevron_right, color: Colors.white),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
        ),
      ],
    );
  }
}
