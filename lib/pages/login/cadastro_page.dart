
import 'package:delivery/helpers/constants.dart';
import 'package:delivery/helpers/helper.dart';
import 'package:delivery/helpers/styles.dart';
import 'package:delivery/helpers/toast.dart';
import 'package:delivery/widgets/action_button.dart';
import 'package:delivery/widgets/h_text.dart';
import 'package:delivery/widgets/input_field.dart';
import 'package:delivery/widgets/my_app_bar.dart';
import 'package:delivery/widgets/my_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:mdi/mdi.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home_page.dart';


class CadastroPage extends StatefulWidget {
  final String code='Cadastro Page';
  const CadastroPage({Key? key}) : super(key: key);

  @override
  _CadastroPageState createState() {
    return _CadastroPageState();
  }
}

class _CadastroPageState extends State<CadastroPage> {
  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }
  final _formKey = GlobalKey<FormState>();
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  MaskedTextController telefoneController =
  MaskedTextController(mask: '(00) 0 0000-0000');
  MaskedTextController cpfController =
  MaskedTextController(mask: '000.000.000-00');
  TextEditingController senhaController = TextEditingController();
  TextEditingController senha2Controller = TextEditingController();
  bool hasBeenPressed = false;
  bool hasAcceptedTermos = false;
  bool hasAcceptedNotificacoes = true;
  bool hasAcceptedclub= false;
  bool hasAcceptedcpfNaNota= false;
  bool  passwordVisible = true;
  bool  repitpasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('Cadastre-se', context, showBack: true),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                sb,
                sb,
                inputField(
                    context: context,
                    radius: 10,
                    fillColor: Colors.white,
                    unableBorderColor: Colors.black26,
                    filled: true,
                    controller: nomeController,
                    hint: 'nome*',
                    label: 'nome*',
                    validator: (String s) {
                      if (hasBeenPressed) {
                        if (s.isEmpty) {
                          return 'Insira o Nome';
                        }
                      } else {
                        return null;
                      }
                    },
                    action: TextInputAction.next,
                    textAlign: TextAlign.start,
                    capitalization: TextCapitalization.words,
                    keyboardType: TextInputType.text,
                    icon: Icons.person),
                sb,
                sb,
                inputField(
                    context: context,
                    radius: 10,
                    controller: emailController,
                    hint: 'email*',
                    label: 'email*',
                    fillColor: Colors.white,
                    unableBorderColor: Colors.black26,
                    filled: true,
                    validator: (String s) {
                      if (hasBeenPressed) {
                        if (s.isEmpty) {
                          return 'Insira o E-mail';
                        }
                        if (!isEmailValid(s)) {
                          return 'E-mail invalido';
                        } else {
                          return null;
                        }
                      } else {
                        return null;
                      }
                    },
                    action: TextInputAction.next,
                    textAlign: TextAlign.start,
                    capitalization: TextCapitalization.none,
                    keyboardType: TextInputType.emailAddress,
                    icon: Icons.mail),
                sb,
                sb,
                inputField(
                    context: context,
                    radius: 10,
                    fillColor: Colors.white,
                    unableBorderColor: Colors.black26,
                    filled: true,
                    controller: telefoneController,
                    hint: 'telefone/whatsapp',
                    label: 'telefone/whatsapp',
                    action: TextInputAction.next,
                    textAlign: TextAlign.start,
                    capitalization: TextCapitalization.none,
                    keyboardType: const TextInputType.numberWithOptions(),
                    icon: Icons.phone),
                sb,
                sb,
                inputField(
                    context: context,
                    radius: 10,
                    controller: senhaController,
                    textAlign: TextAlign.start,
                    hint: 'senha*',
                    fillColor: Colors.white,
                    unableBorderColor: Colors.black26,
                    filled: true,
                    label: 'senha*',
                    validator: (String s) {
                      if (hasBeenPressed) {
                        if (s.isEmpty) {
                          return 'Insira a senha';
                        }
                        if (s.length <= 5) {
                          return 'Senha muito pequena';
                        } else {
                          return null;
                        }
                      } else {
                        return null;
                      }
                    },sufix: GestureDetector(
                  onTap: () {
                    setState(() {
                      passwordVisible = false;
                    });
                  },
                  onLongPressUp: () {
                    setState(() {
                      passwordVisible = true;
                    });
                  },
                  child: Icon(
                      passwordVisible ? Icons.visibility_off: Icons.visibility ),
                ),
                    action: TextInputAction.next,
                    capitalization: TextCapitalization.none,
                    keyboardType: TextInputType.emailAddress,
                    obscure:passwordVisible,
                    icon: Icons.lock),
                sb,
                sb,
                inputField(
                    context: context,
                    radius: 10,
                    fillColor: Colors.white,
                    unableBorderColor: Colors.black26,
                    filled: true,
                    controller: senha2Controller,
                    textAlign: TextAlign.start,
                    hint: 'repita a senha*',
                    label: 'repita a senha*',
                    validator: (String s) {
                      if (hasBeenPressed) {
                        if (s != senhaController.text) {
                          return 'As senhas não conferem =/';
                        }
                        return null;
                      } else {
                        return null;
                      }
                    },sufix: GestureDetector( onTap: () {
                    setState(() {
                      repitpasswordVisible = false;
                    });
                  },
                  onLongPressUp: () {
                    setState(() {
                      repitpasswordVisible = true;
                    });
                  },
                  child: Icon(
                     repitpasswordVisible ? Icons.visibility_off: Icons.visibility ),
                ),
                    action: TextInputAction.next,
                    capitalization: TextCapitalization.none,
                    keyboardType: TextInputType.text,
                    obscure: repitpasswordVisible,
                    icon: Icons.lock),
                /*sb,
                sb,
                myCheckBox(
                    hasAcceptedNotificacoes,
                    'Aceito receber notificações com novidades ',
                    context, () {
                  setState(() {
                    hasAcceptedNotificacoes = !hasAcceptedNotificacoes;
                  });
                }),*/
                sb,
                sb,
                myCheckBox(hasAcceptedNotificacoes, 'Aceito receber novidades', context,
                        () {
                      setState(() {
                        hasAcceptedNotificacoes = !hasAcceptedNotificacoes;
                      });
                    }, expanded: false, textColor: Colors.black),
                sb,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    myCheckBox(hasAcceptedTermos, 'Li e Aceito os', context,
                            () {
                          setState(() {
                            hasAcceptedTermos = !hasAcceptedTermos;
                          });
                        }, expanded: false, textColor: Colors.black),
                    GestureDetector(
                        onTap: () async {
                          const url =
                              'https://www.buycheap.com.br/condicoesdeuso';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical:5.0),
                          child: hText(' Termos e condições de Uso', context,size: 14,
                              color: Colors.blue),
                        )),
                  ],
                ),
                sb,
                sb,
                SizedBox(
                  width: getLargura(context),
                  child: actionButton('Cadastrar', context, () {
                    efetuarCadastro();
                  },
                      textColor: Colors.white,
                      radius: 15,
                      color: corPrimaria,
                      icon: null,
                      size: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }




  void efetuarCadastro() {
    hasBeenPressed = true;
    if (_formKey.currentState!.validate()) {
      if (!hasAcceptedTermos) {
        dToast("É Nescessrio aceitar nossos termos e condições de uso");
        return;
      }
      usuarioController.cadastrarUsuario(
        nomeController.text,
        emailController.text,
        telefoneController.text,
        senhaController.text,
        hasAcceptedNotificacoes,
        hasAcceptedTermos
      ).then((v) {
        if (v != null) {
          fechar(context, widget.code);
          substituir(context, const HomePage(), origin: 'Cadastrar');
        }
      });
    }
  }
}
