import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:delivery/helpers/constants.dart';
import 'package:delivery/helpers/styles.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends BlocBase {
  BehaviorSubject<ThemeData> themeController = BehaviorSubject<ThemeData>();
  Stream<ThemeData> get outTheme => themeController.stream;
  Sink<ThemeData> get inTheme => themeController.sink;

  ThemeController() {
    SharedPreferences.getInstance().then((s) {
      sp = s;
      switchTheme();
    });
  }

  switchTheme() {
    switch (sp!.getString('theme')) {
      case 'light':
        inTheme.add(ligthTheme);
        break;
      case 'dark':
        inTheme.add(darkTheme);
        break;
      default:
        inTheme.add(ligthTheme);
        break;
    }
  }

  setDark() {
    sp!.setString('theme', 'dark');
    inTheme.add(darkTheme);
  }

  setLight() {
    sp!.setString('theme', 'light');
    inTheme.add(ligthTheme);
  }
}


