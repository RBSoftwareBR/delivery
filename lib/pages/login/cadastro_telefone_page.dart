import 'package:delivery/helpers/constants.dart';
import 'package:delivery/helpers/helper.dart';
import 'package:delivery/helpers/references.dart';
import 'package:delivery/helpers/styles.dart';
import 'package:delivery/models/user_model.dart';
import 'package:delivery/widgets/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'code_verification_page.dart';

class CadastroTelefonePage extends StatefulWidget {
  final String code = 'Cadastro Page';
  const CadastroTelefonePage({Key? key}) : super(key: key);

  @override
  _CadastroTelefonePageState createState() {
    return _CadastroTelefonePageState();
  }
}

class _CadastroTelefonePageState extends State<CadastroTelefonePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  MaskedTextController telefoneController =
      MaskedTextController(mask: '(00) 0 0000-0000');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: getLargura(context),
            height: getAltura(context) * 0.15,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Align(
              alignment: const Alignment(-1, 1),
              child: IconButton(
                onPressed: () {
                  fechar(context, widget.code);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFF03A9F4),
                  size: 25,
                ),
                iconSize: 25,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: TextFormField(
              controller: telefoneController,
              obscureText: false,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: '(00) 0 00000000',
                labelText: 'Celular',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 0.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                hoverColor: Colors.black,
                labelStyle: TextStyle(color: Colors.black),
              ),
              style:const TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: Align(
              alignment: const Alignment(1, 1),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 56,
                decoration: BoxDecoration(
                  color: corSecundaria,
                  borderRadius: BorderRadius.circular(0),
                ),
                child: actionButton('Continuar', context, () {
                  enviarCodigo();
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void enviarCodigo() async {
    if (telefoneController.text.length == 16) {
      abrir(context, CodeVerificationPage(telefoneController.text));
    }
  }

  Future<Usuario?> setUser() async {
    var user = auth.currentUser;
    try {
      Usuario usuario =
          Usuario.fromMap((await usuariosRef.doc(user!.uid).get()).data());
      return usuario;
    } catch (err) {
      return Future.value(null);
    }
  }
}
