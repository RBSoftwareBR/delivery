import 'package:delivery/pages/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'controllers/theme_controller.dart';
import 'helpers/styles.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try{
    await Firebase.initializeApp();
  }catch(err){
    // ignore: avoid_print
    print("Erro ao ininiciar Messaging ${err.toString()}");
  }
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  ThemeController themeController = ThemeController();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        <DeviceOrientation>[DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
        const  SystemUiOverlayStyle(statusBarColor: corPrimaria));
    return StreamBuilder<ThemeData>(
        stream: themeController.outTheme,
        builder: (context, snapshot) {
          return MaterialApp(
            title: 'Delivery',debugShowCheckedModeBanner: false,
            theme: snapshot.data,
            home: const SplashPage(),
          );
        });
  }
}

