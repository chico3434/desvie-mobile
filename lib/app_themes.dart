import 'package:flutter/material.dart';

enum AppTheme { White, Dark }

String enumName(AppTheme anyEnum) {
  return anyEnum.toString().split('.')[1];
}

final appThemeData = {
  AppTheme.White: ThemeData(
    brightness: Brightness.light,
  ),
  AppTheme.Dark: ThemeData(
    brightness: Brightness.dark,
  ),
};
