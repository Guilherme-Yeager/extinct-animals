import 'package:flutter/material.dart';

class AppBarCustom {
  static PreferredSizeWidget? buildAppBar(BuildContext context, String label) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(label),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}
