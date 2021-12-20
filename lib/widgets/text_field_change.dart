import 'package:delivery/helpers/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'h_text.dart';

Widget textFieldChange(String label, String? content, function, context,
    {width}) {
  width ??= MediaQuery.of(context).size.width * .6;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            hText(label, context,size: 16),
            const SizedBox(
              height: 3,
            ),
            SizedBox(
              width: width,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: hText(content ?? '', context,
                        size: 16),
                  ),
                ],
              ),
            )
          ],
        ),
        CupertinoButton(
          child: hText(
            function == null ? '' : 'Editar',
            context,size: 16,
            color: function == null ? Colors.grey : corPrimaria,
          ),
          onPressed: function,
        )
      ],
    ),
  );
}
