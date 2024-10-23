import 'package:flutter/material.dart';
import 'package:plantist/core/constants/app_color.dart';
import 'package:plantist/core/constants/app_text_style.dart';

class AppTheme {
  static TextTheme lightTextTheme = TextTheme(
    displayLarge: AppTextStyle.secondaryBold24,
    displayMedium: AppTextStyle.secondaryBold20,
    displaySmall: AppTextStyle.secondaryBold18,
    headlineLarge: AppTextStyle.secondaryBold22,
    headlineMedium: AppTextStyle.secondaryBold18,
    headlineSmall: AppTextStyle.secondaryRegular16,
    titleLarge: AppTextStyle.secondaryBold20,
    titleMedium: AppTextStyle.secondaryBold18,
    titleSmall: AppTextStyle.secondaryRegular16,
    bodyLarge: AppTextStyle.secondaryRegular16,
    bodyMedium: AppTextStyle.secondaryRegular14,
    bodySmall: AppTextStyle.secondaryRegular12,
    labelLarge: AppTextStyle.secondaryBold16,
    labelMedium: AppTextStyle.secondaryRegular14,
    labelSmall: AppTextStyle.secondaryRegular12,
  );

  static TextTheme darkTextTheme = TextTheme(
    displayLarge: AppTextStyle.primaryBold24,
    displayMedium: AppTextStyle.primaryBold20,
    displaySmall: AppTextStyle.primaryBold18,
    headlineLarge: AppTextStyle.primaryBold22,
    headlineMedium: AppTextStyle.primaryBold18,
    headlineSmall: AppTextStyle.primaryRegular16,
    titleLarge: AppTextStyle.primaryBold20,
    titleMedium: AppTextStyle.primaryBold18,
    titleSmall: AppTextStyle.primaryRegular16,
    bodyLarge: AppTextStyle.primaryRegular16,
    bodyMedium: AppTextStyle.primaryRegular14,
    bodySmall: AppTextStyle.primaryRegular12,
    labelLarge: AppTextStyle.primaryBold16,
    labelMedium: AppTextStyle.primaryRegular14,
    labelSmall: AppTextStyle.primaryRegular12,
  );

  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColor.secondary,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColor.primary,
        secondary: AppColor.secondary,
        error: AppColor.redHot,
      ),
      scaffoldBackgroundColor: AppColor.primary,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColor.primary,
        titleTextStyle: AppTextStyle.secondaryBold18,
        iconTheme: const IconThemeData(color: AppColor.secondary),
        actionsIconTheme: const IconThemeData(color: AppColor.secondary),
        toolbarTextStyle: AppTextStyle.primaryBold16.copyWith(color: AppColor.secondary),
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.secondary,
            textStyle: AppTextStyle.primaryBold20,
            iconColor: AppColor.primary),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColor.blue,
        ),
      ),
      // textTheme: AppTheme.lightTextTheme,
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColor.grey;
          }
          return Colors.white;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColor.grey;
          }
          return states.contains(MaterialState.selected) ? AppColor.green : AppColor.grey;
        }),
      ),
      timePickerTheme: const TimePickerThemeData(
        backgroundColor: AppColor.primary,
        hourMinuteColor: AppColor.secondary,
        dialHandColor: AppColor.secondary,
        dialBackgroundColor: AppColor.primary,
        entryModeIconColor: AppColor.secondary,
        hourMinuteTextColor: AppColor.primary,
      ),
      listTileTheme: const ListTileThemeData(
        tileColor: AppColor.primary,
        textColor: AppColor.secondary,
        iconColor: AppColor.secondary,
        selectedColor: AppColor.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColor.grey,
        thickness: 1.0,
        space: 20.0,
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: AppColor.primary,
        textStyle: AppTextStyle.secondaryRegular16,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: AppColor.primary,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColor.secondary,
        secondary: AppColor.primary,
        error: AppColor.redHot,
      ),
      scaffoldBackgroundColor: AppColor.secondary,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColor.secondary,
        titleTextStyle: AppTextStyle.primaryBold18,
        iconTheme: const IconThemeData(color: AppColor.primary),
        actionsIconTheme: const IconThemeData(color: AppColor.primary),
        toolbarTextStyle: AppTextStyle.secondaryBold12,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primary,
            textStyle: AppTextStyle.secondaryBold20,
            iconColor: AppColor.secondary,
            foregroundColor: AppColor.secondary),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: AppColor.primary,
          foregroundColor: AppColor.blue,
        ),
      ),
      // textTheme: AppTheme.darkTextTheme,
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColor.grey;
          }
          return Colors.white;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColor.grey;
          }
          return states.contains(MaterialState.selected) ? AppColor.green : AppColor.grey;
        }),
      ),
      timePickerTheme: const TimePickerThemeData(
        backgroundColor: AppColor.primary,
        hourMinuteColor: AppColor.secondary,
        dialHandColor: AppColor.secondary,
        dialBackgroundColor: AppColor.primary,
        entryModeIconColor: AppColor.secondary,
        hourMinuteTextColor: AppColor.primary,
      ),
      listTileTheme: const ListTileThemeData(
        tileColor: AppColor.secondary,
        textColor: AppColor.primary,
        iconColor: AppColor.secondary,
        selectedColor: AppColor.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColor.grey,
        thickness: 1.0,
        space: 20.0,
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: AppColor.secondary,
        textStyle: AppTextStyle.primaryRegular16,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
