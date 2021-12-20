
import 'package:flutter/material.dart';

Text hText(text, context,
    {double size = 14,
      Color color = Colors.black,
      FontStyle style = FontStyle.normal,
      TextAlign textaling = TextAlign.start,
      overflow= TextOverflow.fade,
      maxLines = 99,
      FontWeight weight = FontWeight.w500}) {

  return Text(
    text,
    textAlign: textaling,maxLines:maxLines ,
    overflow:overflow ,
    style: TextStyle(
      fontSize: size,
      color: color, fontFamily: 'raleway',
      fontWeight: weight,
      fontStyle: style,
    ),
  );
}
