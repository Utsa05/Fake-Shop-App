import 'package:flutter/material.dart';

extension ColorExtension on BuildContext {
  Color get primaryColor => Theme.of(this).primaryColor;
}
