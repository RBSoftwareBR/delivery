import 'package:flutter/material.dart';
import '../helpers/styles.dart';

import 'h_text.dart';

Widget actionButton(String text, context, Function()? onPressed,
    {var icon,
    color = corPrimaria,
    double elevation = 0,
    textColor = Colors.white,
    double radius = 60,
    Widget? customText,
    double size = 20}) {
  return MaterialButton(
    elevation: elevation,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
    color: color,
    disabledColor: Colors.grey,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          icon == null
              ? Container()
              : Icon(
                  icon,
                  size: size,
                  color: textColor,
                ),
          icon == null ? Container() : sb,
          customText ??
              hText(
                text,
                context,
                size: size,
                weight: FontWeight.w500,
                color: textColor,
              ),
        ],
      ),
    ),
    onPressed: onPressed,
  );
}
