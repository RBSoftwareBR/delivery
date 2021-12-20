import 'package:delivery/helpers/gerador_pdf.dart';
import 'package:delivery/helpers/helper.dart';
import 'package:delivery/helpers/styles.dart';
import 'package:delivery/models/pedido_model.dart';
import 'package:delivery/widgets/action_button.dart';
import 'package:delivery/widgets/h_text.dart';
import 'package:delivery/widgets/list_itens/meus_pedidos_list_item.dart';
import 'package:delivery/widgets/list_itens/pagamento_details_list_item.dart';
import 'package:delivery/widgets/my_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:share_extend/share_extend.dart';

// ignore: must_be_immutable
class PedidoDetailsPage extends StatefulWidget {
  final String code = 'Pedido Details Page';
  Pedido pedido;
  PedidoDetailsPage(
    this.pedido, {Key? key}
  ) : super(key: key);

  @override
  _PedidoDetailsPageState createState() {
    return _PedidoDetailsPageState();
  }
}

class _PedidoDetailsPageState extends State<PedidoDetailsPage> {
  ScrollController sc = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar('Pedido', context, showBack: true, actions: [
          IconButton(
            icon: const  Icon(Mdi.share, color: Colors.white),
            onPressed: () async {
              ShareExtend.share((await gerarPdfPedido(widget.pedido)).path,'file');
            },
          )
        ]),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              sb,
              Card(
                  color: Colors.white,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          hText(
                            '#PED${widget.pedido.id}',
                            context,
                            size: 12,
                            color: Colors.grey,
                          ),
                          hText(
                            '${formatarDiaHora(widget.pedido.horaEnviado)}',
                            context,
                            size: 12,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ])),
              Card(
                color: Colors.white,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    if (i == 0) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: hText("Seu Pedido", context),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 10.0),
                              child: Divider(
                                color: Colors.grey,
                                height: 3,
                              ),
                            ),
                            MeusPedidosListItem(
                              widget.pedido.produtos[i],
                            ),
                          ]);
                    }
                    return MeusPedidosListItem(
                      widget.pedido.produtos[i],
                    );
                  },
                  itemCount: widget.pedido.produtos.length,
                  controller: sc,
                ),
              ),
              PagamentoDetailsListItem(widget.pedido),
              sb,
              SizedBox(
                  width: getLargura(context),
                  child: actionButton('Compartilhar pedido', context, () async {
                    ShareExtend.share((await gerarPdfPedido(widget.pedido)).path,'file');
                  })),
            ],
          ),
        ));
  }
}
