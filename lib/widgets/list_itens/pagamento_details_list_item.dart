// ignore_for_file: must_be_immutable

import 'package:delivery/helpers/helper.dart';
import 'package:delivery/helpers/styles.dart';
import 'package:delivery/models/pedido_model.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

import '../h_text.dart';

class PagamentoDetailsListItem extends StatefulWidget {
  Pedido p;
  PagamentoDetailsListItem(this.p, {Key? key}) : super(key: key);

  @override
  _PagamentoDetailsListItemState createState() {
    return _PagamentoDetailsListItemState();
  }
}

class _PagamentoDetailsListItemState extends State<PagamentoDetailsListItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  double total = 0;
  @override
  Widget build(BuildContext context) {
    total = widget.p.valorProdutos;
    return Card(color: Colors.white,
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Mdi.wallet, color: corPrimaria),
                    sb,
                    hText(
                      "Pagamento",
                      context,
                    )
                  ],
                ),
                Text(
                    '${widget.p.formaPagamento == 'inApp' || widget.p.formaPagamento == 'pix' ? 'Online' : 'Entrega'} • ${capitalize(widget.p.formaPagamento)}${widget.p.bandeira == null ? '' : ' • ${widget.p.bandeira}'}',
                    style: const  TextStyle(color: Colors.black))
              ],
            ),
            const  Divider(
              color: Colors.grey,
              height: 3,
            ),
            sb,
          ],
        ),
        subtitle: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      )),
                  Text(total.toStringAsFixed(2),
                      style: const TextStyle(color: corSecundaria,
                        fontWeight: FontWeight.w600,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
