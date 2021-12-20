
// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery/helpers/helper.dart';
import 'package:delivery/helpers/styles.dart';
import 'package:delivery/models/produto_carrinho_model.dart';
import 'package:flutter/material.dart';

class MeusPedidosListItem extends StatefulWidget {
  ProdutoCarrinho produto;
  MeusPedidosListItem(this.produto, {Key? key}) : super(key: key);

  @override
  _MeusPedidosListItemState createState() {
    return _MeusPedidosListItemState();
  }
}

class _MeusPedidosListItemState extends State<MeusPedidosListItem> {
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
    List<Widget> adicionaisTitulos = [];
    if (widget.produto.produto.adicionais != null) {
      for (var i in widget.produto.produto.adicionais!) {
        bool hasSelected = false;
        List<Widget> opcoesSelecionadas = [];
        for (var o in i.opcoes) {
          if (o.isSelected) {
            hasSelected = true;
            opcoesSelecionadas.add(
                Text('${o.nome} (+ R\$ ${o.preco.toStringAsFixed(2)})',
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    )));
          }
        }
        if (hasSelected) {
          adicionaisTitulos.add(Text(i.titulo,
              maxLines: 1,
              style: const  TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)));
          adicionaisTitulos.addAll(opcoesSelecionadas);
        }
      }
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: getLargura(context) * .15,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image(
                        image: CachedNetworkImageProvider(
                            widget.produto.produto.foto!),
                        height: 70,
                        width: 70,
                      ), //produto.foto
                    ),
                  ),
                  sb,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: getLargura(context) * .6,
                        child: Text(widget.produto.produto.titulo,
                            style: TextStyle(
                                fontSize: 19,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1),
                      ),
                      Text(
                        'R\$${widget.produto.totalProduto().toStringAsFixed(2)}',
                        maxLines: 1,
                        style: const TextStyle(
                            color: corSecundaria,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${widget.produto.quantidade} x R\$${widget.produto.totalUnitario().toStringAsFixed(2)}',
                        maxLines: 1,
                        style: const TextStyle(
                            color: Colors.grey,fontWeight: FontWeight.bold,
                            fontSize: 16,
                        ),
                      ),
                      widget.produto.produto.adicionais != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: adicionaisTitulos,
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
