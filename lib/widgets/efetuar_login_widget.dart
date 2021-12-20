import 'package:delivery/helpers/helper.dart';
import 'package:delivery/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

import 'action_button.dart';

efetuarLoginWidget(context) {
  List<Widget> itens = [];
  itens.add(Container(
    height: getAltura(context) * .3,
  ));
  itens.add(Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
          width: getLargura(context) * .5,
          child: actionButton('Efetuar Login', context, () {
            substituir(context, const  LoginPage());
          }, size: 20, icon: Mdi.accountArrowRight)),
    ],
  ));
  return itens;
}
