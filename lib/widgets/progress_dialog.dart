import 'package:delivery/helpers/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:progress_dialog/progress_dialog.dart';

ProgressDialog showProgress(context, {String text = 'Enviando'}) {
  ProgressDialog pr = ProgressDialog(
    context,
    isDismissible: true,
  );
  pr.style(
      message: text,
      messageTextStyle: const TextStyle(
          color: corPrimaria, fontWeight: FontWeight.bold, fontSize: 25),
      child: Center(
          child: Stack(
            children: [
              const SpinKitRing(
                color: corPrimaria,
                size: 50,
                lineWidth: 2,
              ),
              Center(
                  child: Image.asset(
                'assets/ic_launcher.png',
                width: 40,
                height: 40,
              )),
            ],
          )));
  pr.show();
  return pr;
}
