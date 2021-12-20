

import 'package:flutter/material.dart';

double getAltura(context) {
  return MediaQuery.of(context).size.height;
}

double getLargura(context) {
  return MediaQuery.of(context).size.width;
}



String capitalize(String s) {
  return "${s[0].toUpperCase()}${s.substring(1)}";
}

Route animatedRoute(context, page) {
  return PageRouteBuilder(transitionDuration: const Duration(milliseconds: 800),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.decelerate;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

void onError(err, code) {
  // ignore: avoid_print
  print('Error $code: $err');
  //Descomentar caso queira utilizar Analytics
 /* analytics.logEvent(name: 'Erro_${code.replaceAll(' ','_')}', parameters: {
    'log': err.toString(),
    'local': code,
  });*/
}



abrir(BuildContext context, tela, {origin}) {
  //Descomentar caso queira utilizar Analytics
  /*analytics.logEvent(name: 'open_page', parameters: <String, dynamic>{
    'page': tela.code,
    'date': DateTime.now().toIso8601String(),
    'origin': origin.toString(),
  });*/
  // mautic.trackScreen(tela.code.replaceAll(' ', '_').toLowerCase(), tela.code);
  return Navigator.of(context).push(animatedRoute(context, tela));
}

substituir(context, tela, {origin}) {
  //Descomentar caso queira utilizar Analytics
  /*analytics.logEvent(name: 'open_page', parameters: <String, dynamic>{
    'page': tela.code,
    'date': DateTime.now().toIso8601String(),
    'origin': origin.toString(),
  });*/
  // mautic.trackScreen(tela.code.replaceAll(' ', '_').toLowerCase(), tela.code);
  Navigator.of(context).pushReplacement(animatedRoute(context, tela));
}



fechar(context, code, {var returnValue}) {
  Navigator.of(context).pop(returnValue);
  //Descomentar caso queira utilizar Analytics
  /*analytics.logEvent(name: 'close_page', parameters: <String, dynamic>{
    'page': code,
    'date': DateTime.now().toIso8601String()
  });*/
}

formatarDiaHora(v) {
  DateTime d;
  try {
    d = v.toDate();
  } catch (err) {
    d = v;
  }
  return ('${d.day < 10 ? '0${d.day}' : d.day}/${d.month < 10 ? '0${d.month}' : d.month}/${d.year} ${d.hour < 10 ? '0${d.hour}' : d.hour}:${d.minute < 10 ? '0${d.minute}' : d.minute}');
}

formatarTimeOfDay(TimeOfDay d) {
  return ('${d.hour < 10 ? '0${d.hour}' : d.hour}:${d.minute < 10 ? '0${d.minute}' : d.minute}');
}

bool isEmailValid(String email) {
  return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}
