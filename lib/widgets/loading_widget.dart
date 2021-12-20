import 'package:delivery/helpers/helper.dart';
import 'package:delivery/helpers/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  String dots = '';

  bool stop = false;
  @override
  void dispose() {
    super.dispose();
    stop = true;
  }

  bool started = false;
  @override
  Widget build(BuildContext context) {
    /*if (!started) {
      started = true;
      updateDots();
    }*/
    return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 7)).then((v) {
          return true;
        }),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return SizedBox(
              width: getLargura(context),
              height: getAltura(context)*.5,
              child: Stack(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      "Ops!, não conseguimos encontrar o que você procurava.",
                      style: TextStyle(color: corPrimaria, ),
                    )),
                  ),
                ],
              ),
            );
          }
          return SizedBox(
            width: getLargura(context),
            height: getAltura(context)*.5,
          child: Stack(
            children: [
              const SpinKitRing(
                color: corPrimaria,
                size: 100,
              ),
              Center(
                  child: Image.asset(
                'assets/logo_icone.png',
                width: 80,
                height: 100,
                fit: BoxFit.contain,
              )),
            ],
          ),
          );
        });
  }

  Future<void> updateDots() async {
    for (int i = 0; i < 100; i++) {
      if (stop) {
        break;
      }
      await Future.delayed(const Duration(seconds: 1));
      if (dots.length >= 3) {
        dots = '';
      }
      setState(() {
        dots += '.';
      });
    }
  }
}
