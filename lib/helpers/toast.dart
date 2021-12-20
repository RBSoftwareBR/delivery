import 'package:delivery/helpers/styles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

dToast(msg, {color = corSecundaria}) {
  Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      backgroundColor: color,
      fontSize: 16);
}

dToastBranca(msg) {
  Fluttertoast.showToast(
      msg: msg,
      textColor: Colors.black,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.white,
      fontSize: 16);
}

dToastPreto(msg) {
  Fluttertoast.showToast(
      msg: msg,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      fontSize: 16);
}

eToast(msg) {
  Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      fontSize: 16);
}
