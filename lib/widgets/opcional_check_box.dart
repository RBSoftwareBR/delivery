import 'package:delivery/helpers/styles.dart';
import 'package:flutter/material.dart';
import '../helpers/helper.dart';
import 'h_text.dart';

Widget opcionalCheckBox(bool isChecked, text, context, onTap,
    {color= corPrimaria,
    isCombo= false,
    expanded= true,
    textColor,
    width,
    preco}) {
  width ??= getLargura(context);
  return SizedBox(
    width: width,
    child: GestureDetector(
      onTap: onTap,
      child: Row(
        children: <Widget>[
          expanded
              ? Expanded(
                  child: hText(
                  text,
                  context,
                  color: textColorgrey,
                  size: 16,
                ))
              : hText(text, context, color: textColor, size: 20),
          preco == null
              ? Container()
              : hText(preco, context, color: Colors.green, size: 14),
          sb,sb,
          Container(
            decoration: BoxDecoration(
                color: isChecked ? color : Colors.white,
                borderRadius: isCombo
                    ? BorderRadius.circular(0)
                    : BorderRadius.circular(60),
                border: Border.all(color: color, width: 2)),
            child: const Icon(
              Icons.done,
              color: Colors.white,
              size: 18,
            ),
            height: 25,
            width: 25,
          ),
          sb,
        ],
      ),
    ),
  );
}
