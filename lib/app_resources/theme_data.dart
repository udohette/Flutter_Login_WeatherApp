

import 'package:flutter/material.dart';

import 'color_resources.dart';

ThemeData  getApplicationTheme(){

  return ThemeData(
    // main color of the App
    primaryColor: AppColor.primary,
      primaryColorLight: AppColor.primaryLight,
      splashColor: AppColor.primaryLight,
      disabledColor: AppColor.grey,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColor.grey),
  );
}