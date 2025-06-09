import 'package:device_preview/device_preview.dart';
import 'package:extinct_animals/ui/view/home_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(
  DevicePreview(enabled: !kReleaseMode, builder: (context) => HomeView()),
);
