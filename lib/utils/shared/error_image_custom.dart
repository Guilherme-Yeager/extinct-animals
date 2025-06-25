import 'package:flutter/material.dart';

class ErrorImageCustom {
  static Widget errorImage() {
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
