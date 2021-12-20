import 'package:delivery/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../helpers/styles.dart';

myAppBar(String titulo, context,
    {actions,
    bool showBack = false,
    bool close = false,
    double elevation = 0,
    double size = 40,
    centerTitle = true,
    bool isImage = false}) {
  if (showBack) {
    return AppBar(
      elevation: elevation,
      toolbarHeight: 100,
      leading: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: InkWell(
            child: const Icon(
              Icons.chevron_left,
              color: Colors.white,
              size: 30,
            ),
            onTap: () {
              if (close) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: Border.all(),
                        title: const Text('Deseja Sair?'),
                        content: const Text('Tem Certeza?'),
                        actions: <Widget>[
                          MaterialButton(
                            child: const Text(
                              'Cancelar',
                              style: TextStyle(color: Colors.blue),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          MaterialButton(
                            child: const Text(
                              'Sair',
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              SystemNavigator.pop();
                            },
                          )
                        ],
                      );
                    });
              } else {
                Navigator.of(context).pop();
              }
            }),
      ),
      backgroundColor: corPrimaria,
      centerTitle: centerTitle,
      actions: actions,
      leadingWidth: 40,shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(40),
        )) ,
      titleSpacing: 0,
      title: isImage
          ? SizedBox(
              height: getAltura(context) * .06,
              child: Image.asset(
                'assets/logo.png',
              ))
          : Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                titulo,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: size,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'aristotelica',
                ),
              ),
            ),
    );
  }
  return AppBar(
    elevation: elevation,
    backgroundColor: corPrimaria,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(40),
        )) ,
    toolbarHeight: 100,
    iconTheme: const IconThemeData(color: Colors.white),
    centerTitle: centerTitle,
    actionsIconTheme: const IconThemeData(
      color: Colors.white,
    ),
    actions: actions,
    title: isImage
        ? Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: SizedBox(
                height: 62,
                width: 140,
                child: Image.asset(
                  'assets/yupi_branco.png',
                )),
          )
        : Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              titulo,
              style: TextStyle(
                fontSize: size,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'aristotelica',
              ),
            ),
          ),
  );
}
