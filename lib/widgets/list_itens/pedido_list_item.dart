// ignore_for_file: must_be_immutable

import 'package:delivery/helpers/formas_pagamento.dart';
import 'package:delivery/helpers/helper.dart';
import 'package:delivery/helpers/styles.dart';
import 'package:delivery/models/pedido_model.dart';
import 'package:delivery/pages/pedidos/pedido_details_page.dart';
import 'package:flutter/material.dart';

class PedidoListItem extends StatefulWidget {
  Pedido pedido;
  PedidoListItem(this.pedido, {Key? key}) : super(key: key);

  @override
  _PedidoListItemState createState() {
    return _PedidoListItemState();
  }
}

class _PedidoListItemState extends State<PedidoListItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String formaPagamento = '';
  @override
  Widget build(BuildContext context) {
    for (var s in tiposFormasPagamento) {
      if (s['nome'] == widget.pedido.formaPagamento) {
        formaPagamento = s['texto'];
      }
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(shape: dialogShape,color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () async {
              abrir(
                  context,
                  PedidoDetailsPage(
                    widget.pedido,
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                width: getLargura(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${formatarDiaHora(widget.pedido.horaEnviado)}',
                        style: const  TextStyle(fontSize: 15,color: Color(0xFF757575),
                          fontWeight: FontWeight.w500,
                          fontFamily: 'raleway',)),
                    sb,
                    Text(
                      '#PE${widget.pedido.id!.substring(widget.pedido.id!.length - 4)}',
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: const  TextStyle(fontSize: 15,color: Color(0xFF757575),
                        fontWeight: FontWeight.w500,
                        fontFamily: 'raleway',),
                    ),sb,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
