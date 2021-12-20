
import 'package:delivery/helpers/constants.dart';
import 'package:delivery/helpers/helper.dart';
import 'package:delivery/helpers/styles.dart';
import 'package:delivery/helpers/toast.dart';
import 'package:delivery/widgets/action_button.dart';
import 'package:delivery/widgets/h_text.dart';
import 'package:delivery/widgets/input_field.dart';
import 'package:delivery/widgets/recuperar_senha_dialog.dart';
import 'package:flutter/material.dart';

import '../home_page.dart';
import 'cadastro_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  final String code = 'Login Page';
  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  double tamanhoBotao = 50;
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  bool hasBeenPressed = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Stack(
          children: [
            SizedBox(
              width: getLargura(context),
              height: getAltura(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 28),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      sb,
                      sb,
                      sb,
                      sb,
                      Container(
                        width: getLargura(context) * .8,
                        height: getLargura(context) * .4,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqs5DFMXFOV1jxJHz8D42DsSULIpaPzoVDeQ&usqp=CAU'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      sb,
                      sb,
                      inputField(
                          context: context,
                          radius: 10,
                          controller: emailController,
                          borderColor: corPrimaria,
                          fillColor: Colors.white,
                          unableBorderColor: corPrimaria,
                          filled: true,
                          hint: 'email',
                          label: 'email',
                         /* validator: (String? s) {
                            if (hasBeenPressed) {
                              if (s!.isEmpty) {
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
                          },*/
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
                          controller: senhaController,
                          textAlign: TextAlign.start,
                          borderColor: corPrimaria,
                          fillColor: Colors.white,
                          unableBorderColor: corPrimaria,
                          filled: true,
                          hint: 'senha',
                          label: 'senha',
                          /*validator: (String s) {
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
                          },*/
                          action: TextInputAction.done,
                          onSubmitted: () {
                            efetuarLogin();
                          },
                          capitalization: TextCapitalization.none,
                          keyboardType: TextInputType.emailAddress,
                          obscure: true,
                          icon: Icons.lock),
                      sb,
                      sb,
                      SizedBox(
                        width: getLargura(context),
                        height: getAltura(context)*.06,
                        child: actionButton('Entrar', context, () {
                          efetuarLogin();
                        },
                            textColor: Colors.white,
                            color: corPrimaria,
                            icon: null,
                            elevation: 3,
                            radius: 10,
                            size: 18),
                      ),
                      sb,sb,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return RecuperarEmailDialog(
                                        title: "Esqueceu sua senha?",
                                        descriptions:
                                            "Digite seu e-mail para criar uma nova senha",
                                      onRecuperar: (String s){
                                        recuperarSenha(s);
                                      },
                                      );
                                    });
                              },
                              child: hText('Esqueceu a senha?', context,
                                  size: 14, color: Colors.black)),
                          GestureDetector(
                              onTap: () {
                                abrir(context, const CadastroPage());
                              },
                              child: hText('Cadastre-se', context,
                                  size: 14, color: Colors.black)),
                        ],
                      ),
                      sb,
                      sb,
                      SizedBox(
                        width: getLargura(context),
                        child: actionButton('Explorar', context, () {
                          abrir(context, const HomePage(), origin: 'Explorar');
                        },
                            elevation: 0,
                            textColor: Colors.black,
                            color: Colors.white,
                            icon: null,
                            size: 22),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void recuperarSenha(String s) {
    auth.sendPasswordResetEmail(email: s).then((value) {
      dToast("Verifique seu e-mail");
      fechar(context, widget.code);
    }).catchError((err) {
      onError(err, widget.code);
      dToast('Erro ao enviar e-mail: ${err.toString()}');
    });
  }
  void efetuarLogin() {
    hasBeenPressed = true;
    if (_formKey.currentState!.validate()) {
      usuarioController.efetuarLogin(emailController.text, senhaController.text)
          .then((value) {
        if (value != null) {
          sp!.setString('senha', senhaController.text);
          sp!.setString('email', emailController.text);
          substituir(context, const HomePage(), origin: 'Login Entrar');
        }
      });
    }
  }



}
