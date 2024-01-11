import 'package:flutter/material.dart';

extension MaterialStatePropertyColors on Color {
  MaterialStateProperty<Color> get toMaterial => MaterialStatePropertyAll(this);
}

abstract class NflxColors {
  static const lightGreyUnselected = Color.fromRGBO(150, 150, 150, 1);
  static const lightGrey = Color.fromRGBO(110, 100, 95, 1);
  static const grey = Color.fromRGBO(64, 60, 60, 1);
  static const darkGrey = Color.fromRGBO(32, 30, 28, 1);
  static const black = Colors.black;

  static const typoLight = Color.fromRGBO(230, 230, 230, 1);
}

abstract class NflxSpacing {}

abstract class NflxTypo {
  static const String family = "NetflixSans-Regular";
  static const TextStyle regular = TextStyle(
    color: NflxColors.typoLight,
    fontFamily: NflxTypo.family,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle bold = TextStyle(
    color: NflxColors.typoLight,
    fontFamily: NflxTypo.family,
    fontWeight: FontWeight.bold,
  );
}

abstract class NflxButton {
  static final primary = ButtonStyle(
    padding: const MaterialStatePropertyAll(
      EdgeInsets.all(16),
    ),
    backgroundColor: NflxColors.typoLight.toMaterial,
  );
  static final secondary = ButtonStyle(
    padding: const MaterialStatePropertyAll(
      EdgeInsets.all(16),
    ),
    backgroundColor: NflxColors.grey.toMaterial,
  );
}

extension NflxTextStyle on TextStyle {
  TextStyle toSize(double size) => copyWith(fontSize: size);
  TextStyle toColor(Color color) => copyWith(color: color);
}
