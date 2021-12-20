// ignore_for_file: must_be_immutable

import 'package:delivery/helpers/styles.dart';
import 'package:flutter/material.dart';

class CartaoPagamentoWidget extends StatefulWidget {
  String value;
  bool isSelected;
  // ignore: prefer_typing_uninitialized_variables
  var icon;
  // ignore: prefer_typing_uninitialized_variables
  var onPressed;
  Color color;
  CartaoPagamentoWidget(this.value, this.isSelected, this.icon, this.onPressed,
      {Key? key, this.color = corPrimaria}) : super(key: key);

  @override
  _CartaoPagamentoWidgetState createState() => _CartaoPagamentoWidgetState();
}

class _CartaoPagamentoWidgetState extends State<CartaoPagamentoWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onPressed();
        setState(() {
          widget.isSelected = !widget.isSelected;
        });
      },
      child: Container(
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: corPrimaria[50],
      ),
      child:Padding(
        padding: const EdgeInsets.all(11.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            widget.value == 'Pix'
                ? Image.asset(widget.icon)
                : SizedBox(
                    width: 32,
                    height: 32,
                    child: Center(
                      child: Icon(
                        widget.icon,
                        size: 32,
                        color: widget.isSelected ? widget.color : Colors.grey,
                      ),
                    ),
                  ),
            const  SizedBox(width: 5),
            Expanded(
              child: Text(
                widget.value,
                style: const  TextStyle(
                  fontFamily: 'Made',
                  fontSize: 22,
                  color: Colors.grey,
                ),
              ),
            ),
            sb,
            sb,
            Icon(
                widget.isSelected
                    ? Icons.keyboard_arrow_down_sharp
                    : Icons.keyboard_arrow_right_sharp,
                color: corPrimaria,size: 45,),
          ],
        ),
      ),
    ));
  }
}
