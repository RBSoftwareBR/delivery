import 'package:delivery/helpers/styles.dart';
import 'package:flutter/material.dart';

Widget formaPagamentoWidget(String value, bool isSelected, icon, onPressed,
    {color = corSecundaria}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: corPrimaria[50],
      ),
      child: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            value == 'Pix'
                ? Image.asset(icon)
                : SizedBox(
                    width: 32,
                    height: 32,
                    child: Center(
                      child: Icon(
                        icon,
                        size: 32,
                        color: isSelected ? color : Colors.grey,
                      ),
                    ),
                  ),
            const  SizedBox(width: 5),
            Text(
              value,
              style: const  TextStyle(
                fontFamily: 'Made',
                fontSize: 22,
                color: Colors.grey,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_right_sharp,
              color: corPrimaria[50],
              size: 45,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget formaPagamentoNewWidget(String value, bool isSelected, icon, onPressed,
    {color = corSecundaria}) {
  return InkWell(
    onTap: onPressed,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: 32,
          height: 32,
          child: Center(
            child: value == 'Pagamento ● Pix'
                ? Image.asset(icon)
                : Icon(
                    icon,
                    size: 16,
                    color: isSelected ? color : Colors.grey,
                  ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Made',
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        Icon(
          Icons.keyboard_arrow_right_sharp,
          color: corPrimaria[50],
          size: 45,
        ),
      ],
    ),
  );
}
