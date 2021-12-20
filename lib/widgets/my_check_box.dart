import 'package:flutter/material.dart';
import '../helpers/styles.dart';

import 'h_text.dart';

Widget myCheckBox(bool isChecked, text, context, onTap,
    {color= corPrimaria, isCombo =false, expanded= true,textColor}) {
  return GestureDetector(
    onTap: onTap,
    child: Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: isChecked ? color :  Colors.white,
              borderRadius: isCombo
                  ? BorderRadius.circular(0)
                  : BorderRadius.circular(60),
              border: Border.all(color: color, width: 2)),
          child: Icon(
            Icons.done,
            color: isChecked ? Colors.white:Colors.white,
            size: 15,
          ),
          height: 25,
          width: 25,
        ),
        sb,
        expanded ? Expanded(child: hText(text, context,color: Colors.grey, size: 14, )) : hText(text, context,color: textColor, size:14),
      ],
    ),
  );
}
