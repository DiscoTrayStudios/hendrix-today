import 'package:flutter/material.dart';

/// A custom light theme for the app.
final ThemeData hendrixTodayLightMode = ThemeData(
  fontFamily: 'Merriweather-Sans',
  brightness: Brightness.light,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromARGB(255, 202, 81, 39),
    onPrimary: Colors.white,
    secondary: Colors.black,
    onSecondary: Colors.white,
    tertiary: Color.fromARGB(255, 128, 128, 128),
    onTertiary: Colors.white,
    background: Colors.white,
    onBackground: Colors.black,
    error: Color.fromARGB(255, 255, 170, 170),
    onError: Color.fromARGB(255, 255, 100, 100),
    surface: Color.fromARGB(255, 228, 223, 221),
    onSurface: Color.fromARGB(255, 128, 128, 128),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      /// Used for loading screen.
      color: Colors.white,
      fontFamily: 'MuseoBold',
      fontSize: 40,
    ),
    displayMedium: TextStyle(
      /// Used for app bar titles and resource button text.
      color: Colors.white,
      fontFamily: 'MuseoBold',
      fontSize: 30,
    ),
    displaySmall: TextStyle(
      /// Used for app bar titles and resource button text.
      color: Colors.black,
      fontFamily: 'MuseoBold',
      fontSize: 20,
    ),
    headlineLarge: TextStyle(
      // Used for event dialog titles.
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 25,
    ),
    headlineMedium: TextStyle(
      // Used for event card titles.
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
    headlineSmall: TextStyle(
      // Used for dates and event details.
      color: Color.fromARGB(255, 128, 128, 128),
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w200,
      fontSize: 14,
    ),
    bodyLarge: TextStyle(
      // Used for loading label.
      color: Color.fromARGB(255, 202, 81, 39),
      fontFamily: 'Museo',
      fontSize: 25,
    ),
    bodySmall: TextStyle(
      // Used for regular body text.
      color: Colors.black,
      fontFamily: 'Merriweather-Sans',
      fontSize: 14,
    ),
    labelLarge: TextStyle(
      // Used for dropdown menu text and search bar labels.
      color: Colors.white,
      fontFamily: 'Museo',
      fontSize: 15,
    ),
    labelMedium: TextStyle(
      // Used for bold text.
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    labelSmall: TextStyle(
      // Used for body hyperlinks.
      color: Color.fromARGB(255, 202, 81, 39),
      fontFamily: 'Merriweather-Sans',
      decoration: TextDecoration.underline,
      letterSpacing: 0,
      fontSize: 14,
    ),
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
);

/// A custom dark theme for the app.
final ThemeData hendrixTodayDarkMode = ThemeData(
  fontFamily: 'Merriweather-Sans',
  brightness: Brightness.dark,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color.fromARGB(255, 245, 130, 42),
    onPrimary: Colors.white,
    secondary: Colors.white,
    onSecondary: Colors.black,
    tertiary: Color.fromARGB(255, 160, 160, 160),
    onTertiary: Colors.white,
    background: Color.fromARGB(255, 36, 36, 36),
    onBackground: Colors.white,
    error: Color.fromARGB(255, 255, 170, 170),
    onError: Color.fromARGB(255, 137, 0, 0),
    surface: Color.fromARGB(255, 36, 36, 36),
    onSurface: Color.fromARGB(255, 160, 160, 160),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      /// Used for loading screen.
      color: Colors.white,
      fontFamily: 'MuseoBold',
      fontSize: 40,
    ),
    displayMedium: TextStyle(
      /// Used for app bar titles and resource button text.
      color: Colors.white,
      fontFamily: 'MuseoBold',
      fontSize: 30,
    ),
    displaySmall: TextStyle(
      /// Used for app bar titles and resource button text.
      color: Colors.white,
      fontFamily: 'MuseoBold',
      fontSize: 20,
    ),
    headlineLarge: TextStyle(
      // Used for event dialog titles.
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    headlineMedium: TextStyle(
      // Used for event card titles.
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
    headlineSmall: TextStyle(
      // Used for dates and event details.
      color: Color.fromARGB(255, 160, 160, 160),
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w200,
      fontSize: 14,
    ),
    bodyLarge: TextStyle(
      // Used for loading label.
      color: Color.fromARGB(255, 245, 130, 42),
      fontFamily: 'Museo',
      fontSize: 25,
    ),
    bodySmall: TextStyle(
      // Used for regular body text.
      color: Colors.white,
      fontFamily: 'Merriweather-Sans',
      fontSize: 14,
    ),
    labelLarge: TextStyle(
      // Used for dropdown menu text and search bar labels.
      color: Colors.white,
      fontFamily: 'Museo',
      fontSize: 15,
    ),
    labelMedium: TextStyle(
      // Used for bold text.
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    labelSmall: TextStyle(
      // Used for body hyperlinks.
      color: Color.fromARGB(255, 245, 130, 42),
      fontFamily: 'Merriweather-Sans',
      decoration: TextDecoration.underline,
      letterSpacing: 0,
      fontSize: 14,
    ),
  ),
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
);
