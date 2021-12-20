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
    Future.delayed(const Duration(milliseconds: 100)).then((v){
      setState((){
      H = MediaQuery.of(context).size.width * 0.55;
      W =MediaQuery.of(context).size.height * 0.55;
      });
    });
    Future.delayed(const Duration(seconds: 5)).then((v) {
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
            substituir(context, const LoginPage());
          });
        }
      } catch (err) {
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

  double H = 0;
  double W = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      key: scaffoldKey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedContainer(
            width: W,
            height: H,
            duration: const Duration(seconds: 3),
            child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqs5DFMXFOV1jxJHz8D42DsSULIpaPzoVDeQ&usqp=CAU',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
