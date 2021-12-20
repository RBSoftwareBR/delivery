import 'package:delivery/helpers/bandeiras_cartoes.dart';
import 'package:delivery/helpers/formas_pagamento.dart';
import 'package:delivery/helpers/styles.dart';
import 'package:delivery/widgets/cartao_pagamento_widget.dart';
import 'package:delivery/widgets/forma_pagamento_widget.dart';
import 'package:delivery/widgets/list_itens/bandeira_list_item.dart';
import 'package:delivery/widgets/my_app_bar.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class FormaPagamentoPage extends StatefulWidget {
  final String code = 'Forma Pagamento Page';
  const FormaPagamentoPage({Key? key}) : super(key: key);

  @override
  _FormaPagamentoPageState createState() => _FormaPagamentoPageState();
}

class _FormaPagamentoPageState extends State<FormaPagamentoPage> {
  // ignore: prefer_typing_uninitialized_variables
  var pagamentoSelecionado;
  // ignore: prefer_typing_uninitialized_variables
  var cartaoSelecionado;
  ScrollController sc = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('Pagamento', context, showBack: true),
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(
          children: [
            const TabBar(
                labelColor: corPrimaria,
                unselectedLabelColor: corSecundaria,
                indicatorColor: corPrimaria,
                indicatorPadding: EdgeInsets.only(left: 32, right: 32),
                tabs:  [
                  Tab(
                    child: Text(
                      'Pagamento online',
                      style: TextStyle(
                          fontFamily: 'raleway',
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                  ),
                  Tab(
                      child: Text(
                    'Pagamento na entrega',
                    style: TextStyle(
                        fontFamily: 'raleway',
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ))
                ]),
            Expanded(
              child: TabBarView(children: [
                SingleChildScrollView(
                    controller: sc,
                    child: Column(
                      children: getFormasPagamentoOnline(),
                    )),
                SingleChildScrollView(
                    controller: sc,
                    child: Column(
                      children: getFormasPagamentoEntrega(),
                    )),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getFormasPagamentoEntrega() {
    List<Widget> formasPagamento = [];
    for (var s in tiposFormasPagamento) {
      if (s['isSelected']) {
        pagamentoSelecionado = s;
      }
      if (s['nome'] != 'inApp') {
        if (s['nome'] == 'cartão' || s['nome'] == 'debito') {
          ExpandableController ec = ExpandableController();
          formasPagamento.add(ExpandablePanel(
              controller: ec,
              collapsed: Padding(
              padding: const EdgeInsets.all(8.0),
            child: CartaoPagamentoWidget(s['texto'], ec.expanded, s['icon'],
                    () {
                  ec.toggle();
                }),
          ),
              expanded: ListView.builder(
                shrinkWrap: true,
                controller: sc,
                itemCount: s['nome'] == 'cartão'
                    ? tiposBandeirasCartoesCredito.length
                    : tiposBandeirasCartoes.length,
                itemBuilder: (context, i) {
                  /**/
                  return InkWell(
                    onTap: () {
                      for (var s1 in tiposFormasPagamento) {
                        if (s1['nome'] != s['nome']) {
                          s['isSelected'] = false;
                          s1['isSelected'] = false;
                        }
                      }

                      setState(() {
                        s['isSelected'] = !s['isSelected'];
                        s['bandeira'] = s['nome'] == 'cartão'
                            ? tiposBandeirasCartoesCredito[i]
                            : tiposBandeirasCartoes[i];
                        Navigator.of(context).pop([s, null]);
                      });
                    },
                    child: BandeiraListItem(s['nome'] == 'cartão'
                        ? tiposBandeirasCartoesCredito[i]
                        : tiposBandeirasCartoes[i]),
                  );
                },
              ),
          ));
        } else {
          if (s['nome'] != 'pix') {
            formasPagamento.add(Padding(
              padding: const EdgeInsets.all(8.0),
              child: formaPagamentoWidget(
                  s['texto'], s['isSelected'], s['icon'], () {
                for (var s1 in tiposFormasPagamento) {
                  if (s1['nome'] != s['nome']) {
                    s['isSelected'] = false;
                    s1['isSelected'] = false;
                  }
                }

                setState(() {
                  s['isSelected'] = !s['isSelected'];
                  Navigator.of(context).pop([s, null]);
                });
              }),
            ));
          }
        }
      }
    }
    return formasPagamento;
  }

  List<Widget> getFormasPagamentoOnline() {
    List<Widget> formasPagamento = [];

    for (var s in tiposFormasPagamento) {
      if (s['isSelected']) {
        pagamentoSelecionado = s;
      }

      if (s['nome'] == 'pix') {
        formasPagamento.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              formaPagamentoWidget(s['texto'], s['isSelected'], s['icon'], () {
            for (var s1 in tiposFormasPagamento) {
              if (s1['nome'] != s['nome']) {
                s['isSelected'] = false;
                s1['isSelected'] = false;
              }
            }
            setState(() {
              s['isSelected'] = !s['isSelected'];
              Navigator.of(context).pop([s, null]);
            });
          }),
        ));
      }
    }
    return formasPagamento;
  }
}
