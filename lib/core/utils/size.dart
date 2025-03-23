import 'package:flutter/material.dart';

gap({double gap = 8.0}) => SizedBox(
      height: gap,
      width: gap,
    );

Size size(BuildContext context) => MediaQuery.of(context).size;
