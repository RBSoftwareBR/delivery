import 'package:delivery/controllers/carrinho_controller.dart';
import 'package:delivery/controllers/pagamento_controller.dart';
import 'package:delivery/helpers/constants.dart';
import 'package:delivery/helpers/helper.dart';
import 'package:delivery/helpers/styles.dart';
import 'package:delivery/helpers/toast.dart';
import 'package:delivery/models/pedido_model.dart';
import 'package:delivery/models/produto_carrinho_model.dart';
import 'package:delivery/pages/checkout/payment_animation.dart';
import 'package:delivery/widgets/edit_field_dialog.dart';
import 'package:delivery/widgets/forma_pagamento_widget.dart';
import 'package:delivery/widgets/h_text.dart';
import 'package:delivery/widgets/input_field.dart';
import 'package:delivery/widgets/my_app_bar.dart';
import 'package:delivery/widgets/text_field_change.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:mdi/mdi.dart';

import 'forma_pagamento_page.dart';

class CheckOutPage extends StatefulWidget {
  final String code = 'Check Out Page';
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  _CheckOutPageState createState() {
    return _CheckOutPageState();
  }
}

class _CheckOutPageState extends State<CheckOutPage> {
  late PagamentoController pc;
  @override
  void initState() {
    super.initState();
    pc = PagamentoController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  DateFormat df = DateFormat('kk:mm');
  DateFormat df1 = DateFormat('dd/MM ');
  TextEditingController obsController = TextEditingController();
  MoneyMaskedTextController trocoController = MoneyMaskedTextController(
      thousandSeparator: '',
      decimalSeparator: '.',
      leftSymbol: 'R\$',
      precision: 2);
  // ignore: prefer_typing_uninitialized_variables
  var pagamentoSelecionado;
  ExpandableController ec = ExpandableController();
  ExpandableController ecDados = ExpandableController();

  List<double> valorFrete = [];

  double totalPedido = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> itens = [];

    itens.add(dadosUsuarioWidget());
    itens.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: opcionaisWidget(),
      ),
    ));

    itens.add(formasPagamentoWidget());

    itens.add(precosWidget());
    itens.add(sb);
    itens.add(sb);
    itens.add(SizedBox(
      height: 70,
      child: inputField(
        radius: 20,
        context: context,
        textAlignVertical: TextAlignVertical.top,
        unableBorderColor: Colors.grey[400],
        color: Colors.black,
        hint: 'Alguma Observação para o pedido?',
        action: TextInputAction.next,
        textSize: 14,
        expands: true,
        label: 'Alguma Observação para o pedido?',
        onChange: (s) {},
        borderColor: Colors.grey[400],
        controller: obsController,
      ),
    ));
    return Scaffold(
      appBar: myAppBar('Pagamento', context, showBack: true),
      bottomNavigationBar: enviarPedidoButton(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: itens,
          ),
        ),
      ),
    );
  }

  Widget dadosUsuarioWidget() {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(7)),
        width: getLargura(context),
        child: ExpandablePanel(
          controller: ecDados,
          collapsed: Container(),
          header: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: localUser!.nome == null
                              ? ''
                              : '${localUser!.nome}',
                          style: const TextStyle(
                              color: corSecundaria,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                    ], text: 'Meus dados:  '),
                    style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
                    softWrap: true,
                    textAlign: TextAlign.start,
                  ),
                  const Padding(
                    padding:  EdgeInsets.all(8.0),
                    child:  Icon(
                      Mdi.pencilOutline,
                      color: corPrimaria,
                      size: 25,
                    ),
                  )
                ],
              )),
          expanded: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              sb,
              sb,
              textFieldChange(
                'Nome',
                localUser!.nome!,
                () async {
                  var r = await showDialog<String>(
                      context: (context),
                      barrierDismissible: true,
                      builder: (context) {
                        return EditFieldDialog(
                          'Nome',
                          localUser!.nome!,
                        );
                      });
                  if (r != null) {
                    setState(() {
                      localUser!.nome = r;
                      usuarioController.updateUser(localUser!);
                    });
                  }
                },
                context,
              ),
                  textFieldChange(
                'Telefone',
                localUser!.telefone!,
                () async {
                  var r = await showDialog<String>(
                      context: (context),
                      barrierDismissible: true,
                      builder: (context) {
                        return EditFieldDialog(
                          'Telefone',
                          localUser!.telefone!,
                        );
                      });
                  if (r != null) {
                    setState(() {
                      localUser!.telefone = r;
                      usuarioController.updateUser(localUser!);
                    });
                  }
                },
                context,
              ),
              sb,
              sb,
            ]),
          ),
        ),
      ),
    );
  }

  Widget formasPagamentoWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: pagamentoSelecionado == null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const  Text('Pagamento',
                    style: TextStyle(
                        fontFamily: 'raleway',
                        color: Colors.grey,
                        fontSize: 14)),
                InkWell(
                    onTap: () async {
                      var r = await abrir(context, const FormaPagamentoPage());
                      if (r != null) {
                        setState(() {
                          try {
                            pagamentoSelecionado = r[0];
                          } catch (err) {
                            onError(err, widget.code);
                          }
                        });
                      }
                    },
                    child: const Text('Escolher',
                        style: TextStyle(
                            color: corPrimaria,
                            fontFamily: 'raleway',
                            fontSize: 14))),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                formaPagamentoNewWidget(
                    'Pagamento ● ' + pagamentoSelecionado['texto'],
                    true,
                    pagamentoSelecionado['icon'],
                    () {},
                    color: corPrimaria),
                InkWell(
                    onTap: () async {
                      var r = await abrir(context, const FormaPagamentoPage());
                      if (r != null) {
                        setState(() {
                          pagamentoSelecionado = r[0];
                        });
                      }
                    },
                    child: const Text('Trocar',
                        style: TextStyle(
                            color: corPrimaria,
                            fontFamily: 'raleway',
                            fontSize: 14))),
              ],
            ),
    );
  }

  opcionaisWidget() {
    List<Widget> opcionais = [];
    opcionais.add(sb);
    if (pagamentoSelecionado != null) {
      if (pagamentoSelecionado['nome'] == 'dinheiro') {
        opcionais.add(sb);
        opcionais.add(Row(
          children: [
            hText('Troco para', context, size: 18),
            sb,
            SizedBox(
              width: getLargura(context) * .4,
              child: inputField(
                radius: 20,
                context: context,
                unableBorderColor: Colors.grey[400],
                keyboardType: const TextInputType.numberWithOptions(),
                hint: 'Troco para',
                action: TextInputAction.next,
                label: 'Troco para (R\$)',
                onChange: (s) {},
                borderColor: corSecundaria,
                controller: trocoController,
              ),
            ),
          ],
        ));
      }
    }
    return opcionais;
  }

  Widget enviarPedidoButton() {
    return Container(
        width: getLargura(context),
        height: getAltura(context) * .08,
        color: corPrimaria,
        child: StreamBuilder<List<ProdutoCarrinho>>(
            stream: carrinhoController.outCarrinho,
            builder: (context, snap) {
              if (snap.data == null) {
                if (carrinhoController.carrinho != null) {
                  if (carrinhoController.carrinho!.produtos!.isNotEmpty) {
                    carrinhoController.inCarrinho
                        .add(carrinhoController.carrinho!.produtos!);
                  }
                }
                return hText(
                  '',
                  context,
                );
              }
              if (snap.data!.isEmpty) {
                return hText(
                  '',
                  context,
                );
              }

              double total = 0;
              for (ProdutoCarrinho pp in snap.data!) {
                total += pp.totalProduto();
              }
              if (pagamentoSelecionado != null) {
                if (pagamentoSelecionado['bandeira'] != null) {}
              }

              double frete = 0.0;
              totalPedido = total + frete;
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      if (localUser!.nome == null) {
                        dToast('Por favor preencha o nome');
                        return;
                      }
                      if (localUser!.telefone == null) {
                        dToast('Por favor preencha o Telefone');
                        return;
                      }
                      if (pagamentoSelecionado == null) {
                        dToast('Por favor selecione a forma de pagamento ');
                        return;
                      }

                      Pedido pedido = Pedido(
                          formaPagamento: pagamentoSelecionado['nome'],
                          valorTotal: totalPedido,
                          horaEnviado: DateTime.now(),
                          pdfPath: '',
                          trocoPara: trocoController.numberValue,
                          idUser: localUser!.id,
                          usuario: localUser!,
                          bandeira: pagamentoSelecionado['bandeira']['nome'],
                          produtos: snap.data!,
                          valorProdutos: total,
                          obs: obsController.text);
                      abrir(context, PaymentAnimation(pedido));
                    },
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const  Text(
                            'Realizar Pedido',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'raleway',
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'R\$${totalPedido.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'raleway',
                              fontSize: 20,
                            ),
                          ),
                        ]),
                  ));
            }));
  }

  Widget precosWidget() {
    return StreamBuilder<List>(
      builder: (context, snap) {
        if (snap.data == null) {
          return hText(
            '',
            context,
          );
        }
        if (snap.data!.isEmpty) {
          return hText(
            '',
            context,
          );
        }

        double total = 0;
        total = carrinhoController.total;
        List<Widget> itens = [];

        totalPedido = total;
        itens.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text.rich(
                TextSpan(children: <TextSpan>[], text: 'Total:  '),
                style: TextStyle(
                    fontFamily: 'Made',
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                softWrap: true,
                textAlign: TextAlign.start,
              ),
              Expanded(
                child: Text('R\$${(totalPedido).toStringAsFixed(2)}',
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontFamily: 'raleway',
                      color: corSecundaria,
                      fontSize: 14,
                    )),
              ),
            ],
          ),
        ));
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: getLargura(context),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: itens),
            ));
      },
      stream: carrinhoController.outCarrinho,
    );
  }

  pagamentoWidget() {
    return SizedBox(
        width: getLargura(context) * .65,
        child: Text(
          pagamentoSelecionado.toString(),
          style: const TextStyle(
          ),
        ));
  }
}
