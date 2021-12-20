import 'package:delivery/controllers/carrinho_controller.dart';
import 'package:delivery/helpers/helper.dart';
import 'package:delivery/helpers/styles.dart';
import 'package:delivery/models/produto_carrinho_model.dart';
import 'package:delivery/widgets/action_button.dart';
import 'package:delivery/widgets/h_text.dart';
import 'package:delivery/widgets/list_itens/carrinho_list_item.dart';
import 'package:delivery/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

import 'checkout/check_out_page.dart';

class CarrinhoPage extends StatefulWidget {
  final String code = 'Carrinho Page';
  const CarrinhoPage({Key? key}) : super(key: key);

  @override
  _CarrinhoPageState createState() {
    return _CarrinhoPageState();
  }
}

class _CarrinhoPageState extends State<CarrinhoPage> {
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
    return StreamBuilder<List<ProdutoCarrinho>>(
        stream: carrinhoController.outCarrinho,
        builder: (_, carrinho) {
          if (carrinho.data!.isEmpty) {
            return Scaffold(
              appBar: myAppBar(
                'Carrinho',
                context,
                showBack: true,
                isImage: false,
              ),
            );
          }
          return Scaffold(
            appBar: myAppBar(
              'Carrinho',
              context,
              showBack: true,
              isImage: false,
            ),
            body: ListView.builder(
              itemBuilder: (context, i) {
                if (i == 0) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            hText('Seus Itens', context,
                                weight: FontWeight.bold,
                                size: 18,
                                color: Colors.grey),
                            actionButton(
                              '',
                              context,
                              () {
                                fechar(context, widget.code);
                              },
                              color: corPrimaria[50],
                              radius: 25,
                              customText: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(60),
                                        color: corPrimaria),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                  sb,
                                  hText("Adicionar Itens", context,
                                      color: corPrimaria,
                                      weight: FontWeight.bold),
                                ],
                              ),
                              elevation: 0,
                            ),
                          ],
                        ),
                      ),
                      carrinho.data!.isEmpty
                          ? Container()
                          : CarrinhoListItem(carrinho.data![i]),
                    ],
                  );
                }
                if (i == carrinho.data!.length) {
                  return actionButton('Esvaziar Carrinho', context, () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              shape: dialogShape,
                              title: hText('Esvaziar Carrinho?', context,
                                  size: 18),
                              content: hText(
                                  'Tem certeza? está ação é irreversivel!',
                                  context,
                                  size: 14),
                              actions: [
                                actionButton('Cancelar', context, () {
                                  Navigator.of(context).pop();
                                },
                                    size: 18,
                                    color: Colors.white,
                                    textColor: corPrimaria,
                                    elevation: 10),
                                actionButton(
                                  'Esvaziar',
                                  context,
                                  () {
                                    carrinhoController.deletarCarrinho();
                                    fechar(context, widget.code);
                                    fechar(context, widget.code);
                                  },
                                  size: 18,
                                ),
                              ]);
                        });
                  },
                      color: Colors.white,
                      radius: 5,
                      customText: hText("Esvaziar Carrinho", context,
                          color: corPrimaria, weight: FontWeight.bold),
                      elevation: 0,
                      textColor: corPrimaria);
                }
                return CarrinhoListItem(carrinho.data![i]);
              },
              itemCount: carrinho.data!.length + 1,
            ),
            bottomNavigationBar: BottomAppBar(
              child: StreamBuilder(
                  stream: carrinhoController.outCarrinho,
                  builder: (context, snapshot) {
                    return Container(
                        width: getLargura(context),
                        height: getAltura(context) * .08,
                        color: corPrimaria,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Center(
                                  child: Text(
                                      carrinhoController.quantidadeProdutos > 99
                                          ? '99'
                                          : carrinhoController
                                              .quantidadeProdutos
                                              .toString(),
                                      style: const TextStyle(
                                          fontFamily: 'raleway',
                                          color: Colors.white,
                                          fontSize: 20)),
                                ),
                                width: 30,
                                height: 30,
                                color: corTerciaria,
                              ),
                              InkWell(
                                  onTap: () {
                                    abrir(context, const  CheckOutPage());
                                  },
                                  child: const Text(
                                    'Escolher Pagamento',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'raleway',
                                      color: Colors.white,
                                    ),
                                  )),
                              Text(
                                'R\$${carrinhoController.total.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'raleway',
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ));
                  }),
            ),
          );
        });
  }
}
