import 'package:delivery/helpers/styles.dart';
import 'package:flutter/material.dart';

import 'input_field.dart';

class RecuperarEmailDialog extends StatefulWidget {
  final String title, descriptions;
  // ignore: prefer_typing_uninitialized_variables
  final child;
  final String code = 'Recuperar Email Dialog';

  final Function onRecuperar;
  const RecuperarEmailDialog(
      {Key? key, required this.title, required this.descriptions,  this.child,required this.onRecuperar}) : super(key: key);

  @override
  _RecuperarEmailDialogState createState() => _RecuperarEmailDialogState();
}

class _RecuperarEmailDialogState extends State<RecuperarEmailDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  TextEditingController emailController = TextEditingController();
  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
              left: padding,
              top: avatarRadius + padding,
              right: padding,
              bottom: padding),
          margin: const EdgeInsets.only(top: avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(padding),
              boxShadow:const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.descriptions,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 22,
              ),
              inputField(
                  context: context,
                  radius: 20,
                  controller: emailController,
                  unableBorderColor: Colors.grey,
                  borderColor: corPrimaria,
                  hint: 'email',
                  label: 'email',
                  action: TextInputAction.done,
                  onSubmitted: () {
                    widget.onRecuperar(emailController.text);
                  },
                  textAlign: TextAlign.center,
                  capitalization: TextCapitalization.none,
                  keyboardType: TextInputType.emailAddress,
                  icon: Icons.mail),
              const SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                    onPressed: () {
                      widget.onRecuperar(emailController.text);
                    },
                    child: const Text(
                      'Recuperar',
                      style: TextStyle(fontSize: 18),
                    )),
              ),
            ],
          ),
        ),
        Positioned(
          left: padding,
          right: padding,
          child: CircleAvatar(
            radius: avatarRadius,
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(avatarRadius)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/logo.png",fit: BoxFit.fitWidth,),
                )),
          ),
        ),
      ],
    );
  }
}
