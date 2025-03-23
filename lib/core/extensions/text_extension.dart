import 'package:flutter/material.dart';

extension TextThemeExtension on BuildContext {
  TextStyle get h1 => Theme.of(this).textTheme.displayLarge!;
  TextStyle get h2 => Theme.of(this).textTheme.displayMedium!;
  TextStyle get h3 => Theme.of(this).textTheme.displaySmall!;
  
  TextStyle get bodyLargeText => Theme.of(this).textTheme.bodyLarge!;
  TextStyle get bodyMediumText => Theme.of(this).textTheme.bodyMedium!;
  TextStyle get bodySmallText => Theme.of(this).textTheme.bodySmall!;
}
