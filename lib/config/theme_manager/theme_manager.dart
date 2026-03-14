import 'package:flutter/material.dart';
import 'package:movies_app/core/color_manager/color_manager.dart';

abstract class ThemeManager {
  static final ThemeData light = ThemeData(
    scaffoldBackgroundColor: ColorManager.black,
  );
}
