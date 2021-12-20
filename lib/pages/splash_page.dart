import 'package:delivery/helpers/constants.dart';
import 'package:delivery/helpers/helper.dart';
import 'package:delivery/helpers/references.dart';
import 'package:delivery/models/user_model.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'login/login_page.dart';



class SplashPage extends StatefulWidget {
  final String code = 'Splash Page';

  const SplashPage({Key? key}) : super(key: key);
  @override
  _SplashPageState createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((v) {
      try {
        if (auth.currentUser == null) {
          substituir(context, const LoginPage());
        } else {
          usuariosRef.doc(auth.currentUser!.uid).get().then((value) {
            localUser = Usuario.fromMap(value.data());
            usuarioController.inUsuario.add(localUser);

            substituir(context, const HomePage());
          }).catchError((err) {
            onError(err, widget.code);
            substituir(context,const  LoginPage());
          });
        }
      }catch(err){
        onError(err, widget.code);
        substituir(context, const LoginPage());
      }
    });
  }


  @override
  void dispose() {
    super.dispose();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        width: getLargura(context),
        height: getAltura(context) * 1,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(
            'assets/yupi_delivery.jpeg',
            width: MediaQuery.of(context).size.width * 0.35,
            height: MediaQuery.of(context).size.height * 0.35,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
