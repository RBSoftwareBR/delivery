import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:delivery/controllers/carrinho_controller.dart';
import 'package:delivery/controllers/produto_page_controller.dart';
import 'package:delivery/helpers/constants.dart';
import 'package:delivery/helpers/helper.dart';
import 'package:delivery/helpers/styles.dart';
import 'package:delivery/helpers/toast.dart';
import 'package:delivery/models/adicional_model.dart';
import 'package:delivery/models/opcao_model.dart';
import 'package:delivery/models/produto_carrinho_model.dart';
import 'package:delivery/models/produto_model.dart';
import 'package:delivery/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../action_button.dart';
import '../opcional_check_box.dart';

buildProdutoBottomSheet(context, Produto p) {
  done = false;
  quantidadeSelecionadaController = TextEditingController(text: '1');
  observacaoController = TextEditingController();
  ppc = ProdutoPageController(p);
  sc = ScrollController();
  showStickyFlexibleBottomSheet(
    minHeight: 0.8,
    initHeight: 0.8,
    maxHeight: .8,
    headerHeight: 60,
    context: context,
    headerBuilder: (BuildContext context, double offset) {
      return Container(
        decoration: const BoxDecoration(
            borderRadius:  BorderRadius.only(
              topLeft:  Radius.circular(40.0),
              topRight:  Radius.circular(40.0),
            ),
            color: Colors.white),
        child: Stack(
          children: [
            Positioned(
                top: 10,
                right: 10,
                child: Container(
                  decoration: const BoxDecoration(
                      color: corPrimaria,
                      borderRadius: BorderRadius.all(Radius.circular(60))),
                  child: IconButton(
                    color: corPrimaria,
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ))
          ],
        ),
      );
    },
    bodyBuilder: (BuildContext context, double offset) {
      return SliverChildListDelegate(
        <Widget>[
          produtoBottomSheet(
            context,
            offset,
            p,
          )
        ],
      );
    },
    anchors: [0, 0.8, .8],
  );
}

TextEditingController quantidadeSelecionadaController = TextEditingController();
TextEditingController observacaoController = TextEditingController();
late ProdutoPageController ppc;
late ScrollController sc;
bool done = false;
Widget produtoBottomSheet(
  BuildContext context,
  double bottomSheetOffset,
  Produto p,
) {
  return Material(
      child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: StreamBuilder<Produto>(
              stream: ppc.outProduto,
              builder: (context, prod) {
                return StreamBuilder<List<ProdutoCarrinho>>(
                    stream: carrinhoController.outCarrinho,
                    builder: (context, snapshot) {
                      p = prod.data!;
                      int quantidade = 0;
                      if (snapshot.data != null) {
                        for (var pp in snapshot.data!) {
                          if (pp.produto.id == p.id) {
                            quantidade = pp.quantidade;
                            if (!done) {
                              quantidadeSelecionadaController.text =
                                  quantidade.toString();
                              done = true;
                            }
                          }
                        }
                      }

                      List<Widget> itens = [];
                      itens.add(SizedBox(
                          width: getLargura(context),
                          height: getAltura(context) * .3,
                          child: CachedNetworkImage(
                            imageUrl: p.foto!,
                            width: getLargura(context),
                            height: getAltura(context) * .3,
                          )));

                      itens.add(Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          p.titulo,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ));
                      itens.add(Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          '● Imagens meramente ilustrativas',
                          style: TextStyle(
                            color: textColorgrey,
                            fontSize: 16,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ));
                      itens.add(sb);
                      itens.add(StreamBuilder<Produto>(
                          stream: ppc.outProduto,
                          builder: (context, snapshot) {
                            if(snapshot.data == null){
                              return Container();
                            }
                            Produto sp = snapshot.data!;
                            double precoTotal = sp.preco;
                            if (sp.adicionais != null) {
                              for (var a in sp.adicionais!) {
                                for (Opcao op in a.opcoes) {
                                  if (op.isSelected) {
                                    precoTotal += op.preco;
                                  }
                                }
                              }
                            }
                            return Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                "R\$ ${precoTotal.toStringAsFixed(2)}",
                                style: const TextStyle(
                                    color: corSecundaria,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }));
                      itens.add(sb);
                      itens.addAll(adicionaisWidget(p, context));
                      itens.add(sb);
                      itens.add(TextField(
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2.0)),
                            hintText: 'Sem salada',
                            labelText: 'Observação'),
                        textInputAction: TextInputAction.done,
                        controller: observacaoController,
                        maxLines: 4,
                        onSubmitted: (s) {},
                      ));
                      itens.add(sb);
                      itens.add(Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            int quantidade = int.parse(
                                quantidadeSelecionadaController.text);
                            if (quantidade <= 0) {
                              quantidade = 0;
                            } else {
                              quantidade -= 1;
                              quantidadeSelecionadaController.text =
                                  quantidade.toString();
                            }
                          },
                          highlightColor: corSecundaria,
                          splashColor: corSecundaria,
                          minWidth: 35,
                          padding: const EdgeInsets.all(0),
                          height: 35,
                          child: const Center(
                              child: Icon(Icons.remove,
                                  color: Colors.white, size: 24)),
                          color: corPrimaria,
                        ),
                        Container(
                          color: Colors.white,
                          height: 35,
                          width: 40,
                          child: Center(
                              child: TextField(
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,style: const  TextStyle(color:Colors.black),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText:
                                    quantidade.toStringAsFixed(0)),
                            textInputAction: TextInputAction.done,
                            controller: quantidadeSelecionadaController,
                            onSubmitted: (s) {},
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                          )),
                        ),
                        MaterialButton(
                          highlightColor: corSecundaria,
                          splashColor: corSecundaria,
                          onPressed: () {
                            int quantidade = int.parse(
                                quantidadeSelecionadaController.text);
                            quantidade += 1;
                            quantidadeSelecionadaController.text =
                                quantidade.toString();
                          },
                          minWidth: 35,
                          padding: const EdgeInsets.all(0),
                          height: 35,
                          child: const Center(
                              child: Icon(Icons.add,
                                  color: Colors.white, size: 24)),
                          color: corPrimaria,
                        ),
                        sb,
                        Container(
                            child: actionButton('Adicionar', context, () {
                          if (localUser == null) {
                            dToast(
                                'É Nescessario efetuar o Login antes de montar um carrinho!');
                            Future.delayed(const Duration(seconds: 2))
                                .then((v) {
                              substituir(context, const LoginPage());
                            });
                            return;
                          }
                          int quantidade;
                          try {
                            quantidade = int.parse(
                                quantidadeSelecionadaController.text);
                          } catch (err) {
                            dToast("Quantidade Invalida");
                            return;
                          }
                          if (quantidade == 0) {
                            dToast("Quantidade Invalida");
                            return;
                          }

                          if (p.adicionais != null) {
                            for (var a in p.adicionais!) {
                              if (a.isObrigatorio) {
                                int count = 0;
                                for (var o in a.opcoes) {
                                  if (o.isSelected) {
                                    count++;
                                  }
                                }
                                if (count < a.numOpcoesMin) {
                                  dToast(
                                      "É nescessario selecionar pelo menos ${a.numOpcoesMin} ${a.titulo}");
                                  return;
                                }
                              }
                            }
                          }
                          ProdutoCarrinho pp = ProdutoCarrinho(
                              dataInserido: DateTime.now(),
                              produto: p,
                              obs: observacaoController.text,
                              quantidade: quantidade);
                          carrinhoController.adicionarProduto(pp);
                          dToast("Produto Adicionado com sucesso!");
                          Navigator.of(context).pop();
                        },
                                color: corPrimaria,
                                textColor: Colors.white,
                                radius: 3))
                      ]));
                      itens.add(Container(
                        height: getAltura(context) * .2,
                      ));
                      return Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          ),
                        ),
                        height: getAltura(context) * .75,
                        width: getLargura(context),
                        child: ListView.builder(
                          controller: sc,
                          scrollDirection: Axis.vertical,
                          itemCount: itens.length,
                          shrinkWrap: true,
                          itemBuilder: (c, i) {
                            return itens[i];
                          },
                        ),
                      );
                    });
              })));
}

List<Widget> adicionaisWidget(Produto p, context) {
  List<Widget> itens = [];
  if (p.adicionais != null) {
    for (Adicional a in p.adicionais!) {
      itens.add(Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Text(
          a.titulo,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ));
      a.numOpcoesMax == 0
          ? itens.add(Container())
          : itens.add(Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                'Maximo de ${a.numOpcoesMax} itens',
                style: TextStyle(
                  color: textColorgrey,
                  fontSize: 16,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ));

      for (Opcao o in a.opcoes) {
        itens.add(Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: opcionalCheckBox(o.isSelected, o.nome, context, () {
            int max = 0;
            for (Opcao op in a.opcoes) {
              if (op.isSelected) {
                max++;
              }
            }
            if (max >= a.numOpcoesMax && !o.isSelected) {
              dToast("Ops, maximo atingido");
            } else {
              o.isSelected = !o.isSelected;
              ppc.inProduto.add(p);
            }
          },
              preco: o.preco == 0 ? '' : '+ R\$${o.preco.toStringAsFixed(2)}',
              isCombo: a.numOpcoesMax != 1),
        ));
      }
    }
    return itens;
  }
  return [Container()];
}
