import 'package:flutter/material.dart';

import '../../constant/colors.dart';

ThemeData appLightTheme(BuildContext context){
  return ThemeData.light().copyWith(
    primaryColor: AppColors.appColor,
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      titleTextStyle: TextStyle(color: Colors.black),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    iconTheme: const IconThemeData(color: Colors.black45),
    colorScheme: ColorScheme.light(
      primary: AppColors.appColor,
      secondary: AppColors.primarySwatch,
      error: Colors.red,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primarySwatch,
      selectedIconTheme: IconThemeData(color: AppColors.primarySwatch),
      selectedLabelStyle: TextStyle(color: AppColors.primarySwatch),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedIconTheme: IconThemeData(color: Colors.black38),
      unselectedItemColor: Colors.black38,
      unselectedLabelStyle: TextStyle(color: Colors.black38),
    ),
  );
}
