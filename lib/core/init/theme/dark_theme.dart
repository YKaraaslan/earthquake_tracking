import 'package:flutter/material.dart';

import '../../constant/colors.dart';

ThemeData appDarkTheme(BuildContext context) {
  return ThemeData.dark().copyWith(
    primaryColor: AppColors.primarySwatch,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(color: Colors.white),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.primarySwatch,
      secondary: AppColors.appColor,
      error: Colors.red,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black87,
      selectedItemColor: AppColors.primarySwatch,
      selectedIconTheme: IconThemeData(color: AppColors.primarySwatch),
      selectedLabelStyle: TextStyle(color: AppColors.primarySwatch),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedIconTheme: IconThemeData(color: Colors.white10),
      unselectedItemColor: Colors.white10,
      unselectedLabelStyle: TextStyle(color: Colors.white10),
    ),
  );
}
