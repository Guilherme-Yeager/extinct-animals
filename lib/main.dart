import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(
  DevicePreview(enabled: !kReleaseMode, builder: (context) => Placeholder()),
);
