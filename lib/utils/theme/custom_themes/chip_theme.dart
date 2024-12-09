import 'package:flutter/material.dart';
import 'package:leader_app/utils/theme/custom_themes/app_colors.dart';

class TChipTheme {
    TChipTheme._();

static ChipThemeData lightChipTheme = ChipThemeData(
disabledColor: TColors.grey.withOpacity(0.4),
labelStyle: const TextStyle(color: TColors.black),
selectedColor: TColors.PrimaryColor,
padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
checkmarkColor: TColors.white,
);



static ChipThemeData darkChipTheme = const ChipThemeData(
disabledColor: TColors.darkGrey,
labelStyle: TextStyle(color: TColors.white),
selectedColor: TColors.PrimaryColor,
padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
checkmarkColor: TColors.white,

);
}