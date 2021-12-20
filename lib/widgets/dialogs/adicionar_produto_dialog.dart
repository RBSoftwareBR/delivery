
// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery/controllers/carrinho_controller.dart';
import 'package:delivery/helpers/helper.dart';
import 'package:delivery/helpers/styles.dart';
import 'package:delivery/helpers/toast.dart';
import 'package:delivery/models/produto_carrinho_model.dart';
import 'package:delivery/models/produto_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../action_button.dart';

class AdicionaProdutoDialog extends StatefulWidget {
  Produto p;
  ProdutoCarrinho? pp;
  AdicionaProdutoDialog(this.p, {Key? key, this.pp}) : super(key: key);

  @override
  AdicionaProdutoDialogState createState() {
    return AdicionaProdutoDialogState();
  }
}

class AdicionaProdutoDialogState extends State<AdicionaProdutoDialog> {
  bool done = false;
  bool isEdit = false;
  int quantidadeSelecionada = 1;
  TextEditingController quantidadeSelecionadaController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (widget.pp != null) {
      widget.p = widget.pp!.produto;
      isEdit = true;
    }
    if (!done) {
      quantidadeSelecionada = widget.pp!.quantidade;
      done = true;
    }
    quantidadeSelecionadaController.addListener(() {
      setState(() {
        try {
          quantidadeSelecionada =
              int.parse(quantidadeSelecionadaController.text);
        } catch (err) {
          onError(err,'Adicionar Produto Dialog');
        }
      });
    });
    return AlertDialog(
      backgroundColor: Colors.transparent,
      actions: [
        SizedBox(
          width: getLargura(context),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: getLargura(context) * .05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                actionButton('Cancelar', context, () {
                  Navigator.of(context).pop();
                }, textColor: Colors.black),
                actionButton(
                    isEdit ? 'Editar' : 'Adicionar', context, () async {
                  if (quantidadeSelecionada != 0) {
                    widget.pp!.quantidade = quantidadeSelecionada;
                    var result =
                        await carrinhoController.updateProduto(widget.pp!);
                    if (result) {
                      dToast("Produto Adicionado Com Sucesso!");
                      Navigator.of(context).pop();
                    }
                  } else {
                    dToast('Por favor Selecione a quantidade desejada');
                  }
                }, textColor: Colors.black),
              ],
            ),
          ),
        )
      ],
      content: Stack(
        children: <Widget>[
          Container(
            height: 300,
            padding: const EdgeInsets.only(
                left: padding,
                top: avatarRadius + padding,
                right: padding,
                bottom: padding),
            margin: const EdgeInsets.only(top: avatarRadius),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(padding),
                boxShadow: const [
                   BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 10),
                      blurRadius: 10),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  SizedBox(
                  width: getLargura(context) * .65,
                  child: Text(
                    widget.pp!.produto.titulo,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                ),sb,
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    widget.pp!.produto.descricao,
                    style: const TextStyle(color: Colors.grey, fontSize: 18),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),sb,
                Row(
                  children: [
                    InkWell(
                        child:const Icon(
                          Icons.remove,
                          color: Colors.red,
                          size: 30,
                        ),
                        onTap: () {
                          if (quantidadeSelecionada >= 0) {
                            quantidadeSelecionada = 0;
                          } else {
                            setState(() {
                              quantidadeSelecionada--;
                            });
                          }
                        }),
                    SizedBox(
                      width: getLargura(context) * .35,
                      child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            valueIndicatorColor:
                                corSecundaria, // This is what you are asking for
                            inactiveTrackColor:
                            const Color(0xFF8D8E98), // Custom Gray Color
                            activeTrackColor: Colors.white,
                            thumbColor: Colors.red,
                            overlayColor:
                            const Color(0x29EB1555), // Custom Thumb overlay Color
                            thumbShape:
                            const RoundSliderThumbShape(enabledThumbRadius: 12.0),
                            overlayShape:
                            const  RoundSliderOverlayShape(overlayRadius: 20.0),
                          ),
                          child: Slider(
                            value: quantidadeSelecionada >= 99
                                ? 99.0
                                : quantidadeSelecionada.toDouble(),
                            min: 0.0,
                            max: 100.0,
                            divisions: 99,
                            activeColor: corSecundaria,
                            label: quantidadeSelecionada.toString(),
                            onChanged: (double value) {
                              setState(() {
                                quantidadeSelecionadaController.text =
                                    value.toInt().toString();
                              });
                            },
                          )),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                quantidadeSelecionada.toStringAsFixed(0)),
                        textInputAction: TextInputAction.done,
                        controller: quantidadeSelecionadaController,
                        keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                      ),
                    ),
                    GestureDetector(
                        child: const Icon(
                          Icons.add,
                          color: Colors.green,
                          size: 30,
                        ),
                        onTap: () {
                          setState(() {
                            quantidadeSelecionada++;
                          });
                        }),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: padding,
            right: padding,
            child: CircleAvatar(
              radius: avatarRadius,
              backgroundColor: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  imageUrl: widget.pp!.produto.foto!,
                  fit: BoxFit.fill,
                  imageBuilder: (context, img) {
                    return Container(width: productRadius,height: productRadius,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200.0),
                            image: DecorationImage(
                                fit: BoxFit.cover, image: img)));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
