import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery/controllers/carrinho_controller.dart';
import 'package:delivery/helpers/helper.dart';
import 'package:delivery/helpers/styles.dart';
import 'package:delivery/helpers/toast.dart';
import 'package:delivery/models/produto_carrinho_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mdi/mdi.dart';

import '../action_button.dart';
import '../h_text.dart';

// ignore: must_be_immutable
class CarrinhoListItem extends StatefulWidget {
  ProdutoCarrinho produto;
  CarrinhoListItem(this.produto, {Key? key}) : super(key: key);

  @override
  _CarrinhoListItemState createState() {
    return _CarrinhoListItemState();
  }
}

class _CarrinhoListItemState extends State<CarrinhoListItem> {
  @override
  void initState() {
    super.initState();
    quantidadeSelecionadaController.text = widget.produto.quantidade.toString();
  }

  TextEditingController quantidadeSelecionadaController =
      TextEditingController();
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
            opcoesSelecionadas
                .add(Text('${o.nome} (+ R\$ ${o.preco.toStringAsFixed(2)})',
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
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)));
          adicionaisTitulos.addAll(opcoesSelecionadas);
        }
      }
    }
    return Card(
      shape: dialogShape,
      color: Colors.white,
      child: StreamBuilder<List<ProdutoCarrinho>>(
          stream: carrinhoController.outCarrinho,
          builder: (context, snapshot) {
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
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
                                  height: getLargura(context) * .15,
                                  child: Center(
                                    child: CachedNetworkImage(
                                      imageUrl: widget.produto.produto.foto!,
                                      height: getLargura(context) * .15,
                                      alignment: Alignment.center,
                                      fit: BoxFit.contain,
                                      width: getLargura(context) * .15,
                                    ),
                                  )),
                              sb,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: getLargura(context) * .6,
                                    child: Text(widget.produto.produto.titulo,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
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
                                  widget.produto.produto.adicionais != null
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: adicionaisTitulos,
                                        )
                                      : Container(),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding:
                              EdgeInsets.only(right: getLargura(context) * .05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                child: const Icon(
                                  Mdi.trashCanOutline,
                                  color: corPrimaria,
                                  size: 20,
                                ),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                            shape: dialogShape,
                                            title: hText(
                                                'Remover produto ${widget.produto.produto.titulo}',
                                                context,
                                                size: 18),
                                            content: hText(
                                                'Tem certeza? está ação é irreversivel!',
                                                context,
                                                size: 14),
                                            actions: [
                                              actionButton('Cancelar', context,
                                                  () {
                                                Navigator.of(context).pop();
                                              },
                                                  size: 18,
                                                  color: Colors.white,
                                                  textColor: corPrimaria,
                                                  elevation: 10),
                                              actionButton(
                                                'Remover',
                                                context,
                                                () {
                                                  carrinhoController
                                                      .removerProduto(
                                                          widget.produto);
                                                  dToast(
                                                      '${widget.produto.produto.titulo} Removido com Sucesso!');
                                                  Navigator.of(context).pop();
                                                  if (carrinhoController
                                                      .carrinho!
                                                      .produtos!
                                                      .isEmpty) {
                                                    Navigator.of(context).pop();
                                                  }
                                                },
                                                size: 18,
                                              ),
                                            ]);
                                      });
                                },
                              ),
                              sb,
                              sb,
                              SizedBox(
                                height: 25,
                                width: getLargura(context) * .35,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    MaterialButton(
                                      onPressed: () {
                                        for (var pp in snapshot.data!) {
                                          if (pp.produto.id ==
                                              widget.produto.produto.id) {
                                            if (pp.quantidade - 1 > 0) {
                                              pp.quantidade -= 1;
                                              carrinhoController
                                                  .updateProduto(pp);
                                              quantidadeSelecionadaController
                                                      .text =
                                                  pp.quantidade.toString();
                                              widget.produto.quantidade =
                                                  pp.quantidade;
                                            } else {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                        shape: dialogShape,
                                                        title: hText(
                                                            'Remover produto ${widget.produto.produto.titulo}',
                                                            context,
                                                            size: 18),
                                                        content: hText(
                                                            'Tem certeza? está ação é irreversivel!',
                                                            context,
                                                            size: 14),
                                                        actions: [
                                                          actionButton(
                                                              'Cancelar',
                                                              context, () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                              size: 18,
                                                              color:
                                                                  Colors.white,
                                                              textColor:
                                                                  corPrimaria,
                                                              elevation: 10),
                                                          actionButton(
                                                            'Remover',
                                                            context,
                                                            () {
                                                              carrinhoController
                                                                  .removerProduto(
                                                                      widget
                                                                          .produto);
                                                              dToast(
                                                                  '${widget.produto.produto.titulo} Removido com Sucesso!');
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            size: 18,
                                                          ),
                                                        ]);
                                                  });
                                            }
                                          }
                                        }
                                      },
                                      highlightColor: corSecundaria,
                                      splashColor: corSecundaria,
                                      minWidth: 25,
                                      padding: const EdgeInsets.all(0),
                                      height: 25,
                                      child: const Center(
                                          child: Icon(Icons.remove,
                                              color: Colors.white, size: 24)),
                                      color: widget.produto.quantidade == 1
                                          ? Colors.grey
                                          : corPrimaria,
                                    ),
                                    Container(
                                      color: Colors.white,
                                      height: 60,
                                      width: 30,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 25.0),
                                        child: TextField(
                                          textAlign: TextAlign.center,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: widget
                                                  .produto.quantidade
                                                  .toStringAsFixed(0)),
                                          textInputAction: TextInputAction.done,
                                          controller:
                                              quantidadeSelecionadaController,
                                          style: const TextStyle(color: Colors.black),
                                          onSubmitted: (s) {
                                            try {
                                              int v = int.parse(s);
                                              for (var pp in snapshot.data!) {
                                                if (pp.produto.id ==
                                                    widget.produto.produto.id) {
                                                  pp.quantidade = v;
                                                  if (pp.quantidade >= 0) {
                                                    quantidadeSelecionadaController
                                                            .text =
                                                        pp.quantidade
                                                            .toString();
                                                    widget.produto.quantidade =
                                                        pp.quantidade;
                                                    carrinhoController
                                                        .updateProduto(pp);
                                                  } else {
                                                    quantidadeSelecionadaController
                                                            .text =
                                                        pp.quantidade
                                                            .toString();
                                                    widget.produto.quantidade =
                                                        pp.quantidade;
                                                    carrinhoController
                                                        .removerProduto(pp)
                                                        .then((v) {
                                                      dToast(
                                                          'Produto removido com sucesso!');
                                                    });
                                                  }
                                                }
                                              }
                                            } catch (err) {
                                              dToast(
                                                  'Desculpe não conseguimos converter a quantidade, tente novamente');
                                              quantidadeSelecionadaController
                                                      .text =
                                                  widget.produto.quantidade
                                                      .toString();
                                            }
                                          },
                                          keyboardType: const TextInputType
                                              .numberWithOptions(decimal: true),
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9]')),
                                          ],
                                        ),
                                      ),
                                    ),
                                    MaterialButton(
                                      highlightColor: corSecundaria,
                                      splashColor: corSecundaria,
                                      onPressed: () {
                                        for (var pp in snapshot.data!) {
                                          if (pp.produto.id ==
                                              widget.produto.produto.id) {
                                            pp.quantidade += 1;
                                            quantidadeSelecionadaController
                                                    .text =
                                                pp.quantidade.toString();
                                            widget.produto.quantidade =
                                                pp.quantidade;
                                            carrinhoController
                                                .updateProduto(pp);
                                          }
                                        }
                                      },
                                      minWidth: 25,
                                      padding: const EdgeInsets.all(0),
                                      height: 25,
                                      child: const Center(
                                          child: Icon(Icons.add,
                                              color: Colors.white, size: 24)),
                                      color: corPrimaria,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: getLargura(context),
                  child: Divider(
                    color: Colors.grey[400],
                    height: 2,
                    thickness: 1,
                  ),
                )
              ],
            );
          }),
    );
  }
}
