import 'package:flutter/material.dart';

const Map<int, Color> colorPalletBlack = {
  50: Color(0xffE0E0E0),
  100: Color(0xffB3B3B3),
  200: Color(0xff808080),
  300: Color(0xff4D4D4D),
  400: Color(0xff262626),
  500: Color(0xff000000),
  600: Color(0xff000000),
  700: Color(0xff000000),
  800: Color(0xff000000),
  900: Color(0xff000000),
};
const Map<int, Color> colorPalletTerciary = {
  50: Color(0xffE0E0E0),
  100: Color(0xffB3B3B3),
  200: Color(0xff808080),
  300: Color(0xff4D4D4D),
  400: Color(0xff262626),
  500: Color(0xff000000),
  600: Color(0xff000000),
  700: Color(0xff000000),
  800: Color(0xff000000),
  900: Color(0xff000000),
};
const Map<int, Color> colorPalletSecondary = {
  50: Color(0xffEAF5EA),
  100: Color(0xffC9E7CB),
  200: Color(0xffA6D7A8),
  300: Color(0xff82C785),
  400: Color(0xff67BB6A),
  500: Color(0xff4CAF50),
  600: Color(0xff45A849),
  700: Color(0xff3C9F40),
  800: Color(0xff339637),
  900: Color(0xff248627),
};
const Map<int, Color> colorPalletPrimary = {
  50: Color(0xffFCE9E3),
  100: Color(0xffF8C9BA),
  200: Color(0xffF3A58C),
  300: Color(0xffEE805E),
  400: Color(0xffEA653C),
  500: Color(0xffE64A19),
  600: Color(0xffE34316),
  700: Color(0xffDF3A12),
  800: Color(0xffDB320E),
  900: Color(0xffD52208),
};
const MaterialColor corPrimaria = MaterialColor(0xffEA653C, colorPalletPrimary);
const MaterialColor corSecundaria =
MaterialColor(0xff67BB6A, colorPalletSecondary);
const MaterialColor corTerciaria =
MaterialColor(0xff4D4D4D, colorPalletTerciary);
Color backgroundColor = Colors.white;
Color textColor = Colors.black;
Color textColorwhite = const Color(0xFFFFFFFF);
Color textColorgrey = const Color(0xFF757575);
Color botaoazul = const Color(0xFFD3EEFF);
var cardShape = const RoundedRectangleBorder(
    borderRadius:  BorderRadius.all(Radius.circular(5.0)));
var dialogShape = const RoundedRectangleBorder(
    borderRadius:  BorderRadius.all(Radius.circular(20.0)));
final ThemeData ligthTheme = ThemeData.light().copyWith(
    dividerColor: colorPalletBlack[300],
    splashColor: colorPalletTerciary[300],
    backgroundColor: textColorwhite,
    primaryColor: corPrimaria,
    primaryColorDark: corPrimaria[900],
    cardColor: colorPalletTerciary[50],
    scaffoldBackgroundColor: colorPalletTerciary[50],
    bottomAppBarTheme: BottomAppBarTheme(
      color: colorPalletBlack[500],
      elevation: 20,
    ),
    errorColor: Colors.red,
    textTheme: TextTheme(
        bodyText1: TextStyle(color: Colors.grey[600], fontSize: 14),
        bodyText2: TextStyle(color: Colors.grey[400], fontSize: 14),
        headline1: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14)),
    primaryColorLight: corPrimaria[400],
    buttonTheme: ButtonThemeData(
        splashColor: colorPalletTerciary[300],
        buttonColor: corPrimaria,
        disabledColor: colorPalletBlack[400],
        shape: Border.all()));
final ThemeData darkTheme = ThemeData.dark().copyWith(
    dividerColor: colorPalletBlack[300],
    splashColor: colorPalletTerciary[300],
    backgroundColor: textColorwhite,
    primaryColor: corPrimaria,
    primaryColorDark: corPrimaria[900],
    cardColor: colorPalletTerciary[50],
    scaffoldBackgroundColor: colorPalletBlack[400],
    bottomAppBarTheme: BottomAppBarTheme(
      color: colorPalletBlack[500],
      elevation: 20,
    ),
    errorColor: Colors.red,
    textTheme: TextTheme(
        bodyText1: TextStyle(color: Colors.grey[600], fontSize: 14),
        bodyText2: TextStyle(color: Colors.grey[400], fontSize: 14),
        headline1: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14)),
    primaryColorLight: corPrimaria[400],
    buttonTheme: ButtonThemeData(
        splashColor: colorPalletTerciary[300],
        buttonColor: corPrimaria,
        disabledColor: colorPalletBlack[400],
        shape: Border.all()));


const double padding = 20;
const double avatarRadius = 45;
const double productRadius = 85;
const SizedBox sb = SizedBox(width:10,height:10);