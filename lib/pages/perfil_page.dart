import 'package:delivery/helpers/constants.dart';
import 'package:delivery/helpers/helper.dart';
import 'package:delivery/helpers/references.dart';
import 'package:delivery/helpers/styles.dart';
import 'package:delivery/helpers/toast.dart';
import 'package:delivery/widgets/action_button.dart';
import 'package:delivery/widgets/default_dialog.dart';
import 'package:delivery/widgets/efetuar_login_widget.dart';
import 'package:delivery/widgets/h_text.dart';
import 'package:delivery/widgets/input_field.dart';
import 'package:delivery/widgets/my_app_bar.dart';
import 'package:delivery/widgets/text_field_change.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:mdi/mdi.dart';

import 'login/login_page.dart';

class PerfilPage extends StatefulWidget {
  final String code = 'Perfil Page';
  const PerfilPage({Key? key}) : super(key: key);

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ScrollController sc = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar('Meu Perfil', context, showBack: false),
        body: Column(
            children: localUser == null
                ? efetuarLoginWidget(context)
                : perfilWidget()));
  }

  Future? editFieldDialog(String field, String? content, context) {
    var tec = TextEditingController(text: content ?? '');
    if (field == 'CPF') {
      tec = MaskedTextController(text: content, mask: '000.000.000-00');
    }
    if (field == 'Telefone') {
      tec = MaskedTextController(text: content, mask: '(00)0 0000-0000');
    }

    return showDialog<String>(
        context: (context),
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text("Editar $field"),
            content: inputField(
              keyboardType: field == 'CPF' || field == 'Telefone'
                  ? TextInputType.number
                  : field == 'Email'
                      ? TextInputType.emailAddress
                      : TextInputType.text,
              controller: tec,
              context: context,
              radius: 20,
              borderColor: corPrimaria,
              label: field,
            ),
            actions: <Widget>[
              actionButton(
                "Cancelar",
                context,
                () {
                  Navigator.pop(
                    context,
                  );
                },
                textColor: corPrimaria,
                size: 16,
                color: Colors.white,
              ),
              sb,
              actionButton(
                "Alterar",
                context,
                () {
                  Navigator.pop(context, tec.text);
                },
                color: corPrimaria,
                size: 16,
                textColor: Colors.white,
              ),
            ],
          );
        });
  }

  perfilWidget() {
    List<Widget> itens = [];
    itens.add(sb);
    itens.add(sb);
    itens.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: textFieldChange('Nome', localUser!.nome, () async {
        var r = await editFieldDialog(
            'Nome', localUser!.nome ?? '', context);
        if (r != null) {
          setState(() {
            localUser!.nome = r;
            usuarioController.updateUser(localUser!);
          });
        }
      }, context),
    ));
    itens.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: textFieldChange('Email', localUser!.email!, null, context),
    ));
    itens.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: textFieldChange(
          'Telefone', localUser!.telefone == null ? '' : localUser!.telefone!,
          () async {
        var r = await editFieldDialog('Telefone',
            localUser!.telefone ?? '', context);
        if (r != null) {
          setState(() {
            localUser!.telefone = r;
            usuarioController.updateUser(localUser!);
          });
        }
      }, context),
    ));
    itens.add(sb);
    itens.add(sb);
    itens.add(const  Divider(
      color: Colors.grey,
      height: 1,
      thickness: 1,
    ));
    itens.add(sb);
    itens.add(sb);
    itens.add(sb);
    itens.add(sb);
    itens.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          child: actionButton('Alterar Senha', context, () {
            recuperar();
      },
              color: Colors.white,
              size: 20,
              textColor: corPrimaria,
              elevation: 5,
              icon: Mdi.lock))
    ]));
    itens.add(sb);
    itens.add(sb);
    itens.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
          width: getLargura(context) * .5,
          child: actionButton('Sair', context, () {
            usuarioController.logout();
            substituir(context, const  LoginPage());
          },
              color: Colors.white,
              textColor: corPrimaria,
              size: 20,
              elevation: 5,
              icon: Icons.power_settings_new))
    ]));

    itens.add(sb);
    itens.add(sb);
    itens.add(sb);
    itens.add(sb);
    itens.add(sb);
    itens.add(sb);
    itens.add(sb);
    itens.add(sb);
    itens.add(Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
            child: hText('Excluir Conta', context),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return DefaultDialog(
                        title: 'Excluir Conta',
                        img: Image.asset('assets/logo.png'),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              hText('Tem certeza? está ação é Irreversível!',
                                  context),
                              sb,
                              Row(
                                children: [
                                  MaterialButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const  Text(
                                        'Cancelar',
                                        style: TextStyle(fontSize: 18),
                                      )),
                                  MaterialButton(
                                      onPressed: () {
                                        usuariosRef.doc(localUser!.id).delete();
                                        auth.currentUser!.delete();
                                        usuarioController.logout();
                                        substituir(context, const  LoginPage());
                                      },
                                      child: const  Text(
                                        'Excluir',
                                        style: TextStyle(fontSize: 18),
                                      )),
                                ],
                              ),
                            ]));
                  });
            }),
      ],
    ));

    return itens;
  }

  void recuperar() {
    auth.sendPasswordResetEmail(email: localUser!.email!).then((value) {
      dToast("Verifique seu e-mail");
    }).catchError((err) {
      onError(err, widget.code);
      dToast('Erro ao enviar e-mail: ${err.toString()}');
    });
  }
}
