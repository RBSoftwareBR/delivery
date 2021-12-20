import 'dart:async';

import 'package:delivery/helpers/constants.dart';
import 'package:delivery/helpers/helper.dart';
import 'package:delivery/helpers/references.dart';
import 'package:delivery/helpers/styles.dart';
import 'package:delivery/helpers/toast.dart';
import 'package:delivery/models/user_model.dart';
import 'package:delivery/widgets/action_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_advanced/sms_advanced.dart';
import '../home_page.dart';

class CodeVerificationPage extends StatefulWidget {
  final String code = 'Code Verification Page';
  final String telefone;

  const CodeVerificationPage(this.telefone, {Key? key}) : super(key: key);

  @override
  _CodeVerificationPageState createState() => _CodeVerificationPageState();
}

class _CodeVerificationPageState extends State<CodeVerificationPage> {
  // ignore: prefer_typing_uninitialized_variables
  var onTapRecognizer;
  String? verificationId;
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";
  late StreamController<ErrorAnimationType> errorController;
  bool hasError = false;
  String currentText = "";
  String error = '';
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    sendCode();
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () async {
        sendCode();
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  bool recived = false;
  void verifyMessages(List<SmsMessage> messages ) {
    messages.sort((a,b)=>a.dateSent!.compareTo(b.dateSent!));
    messages = messages.reversed.toList();
    for(var m in messages){

      if(m.dateSent!.isAfter(DateTime.now().subtract(const Duration(seconds:120)))) {
        if (m.body!.toLowerCase().contains('delivery')){
          textEditingController.text = m.body!.split(' ')[0];
          recived = true;
          break;
        }
      }
    }
  }

  void onTimeout() {
  }

  sendCode() async {
    var status = await Permission.sms.status;
    if (status.isDenied) {
      await [Permission.sms].request();
    }

    await auth.verifyPhoneNumber(
        phoneNumber:
            '+55${widget.telefone.replaceAll('(', '').replaceAll(')', '').replaceAll('-', '')}',
        codeSent: (String verificationId, int? resendToken) async {
          verificationId = verificationId;
          dToast("Codigo Enviado");
          listenForSMS();
        },
        verificationCompleted: (pc) async {
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId!, smsCode: currentText);
          auth.signInWithCredential(credential).then((v) async {
           dToast("Numero verificado com sucesso!");
            Usuario? u = await setUser();
            if(u!= null) {
              usuarioController.updateUser(u);
              abrir(context, const HomePage());
            }
          });
        },
        verificationFailed: (err) {

        },
        timeout: const Duration(seconds: 60 * 2),
        codeAutoRetrievalTimeout: (String verificationId) {
        });
  }

  listenForSMS() async{
    recived = false;
    var status = await Permission.sms.status;
    if (status.isGranted) {
      for(int i = 0; i< 24; i++) {
        if(!recived) {
          await Future.delayed(const Duration(seconds: 5));
          SmsQuery query = SmsQuery();
          query.querySms().asStream().listen((event) {
            List<SmsMessage> messages = event;
            verifyMessages(messages);
          });
        }
      }
    }
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: GestureDetector(
          onTap: () {},
          child: Column(
            children: <Widget>[
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
              const Padding(
                padding:  EdgeInsets.symmetric(vertical: 8.0),
                child:  Text(
                  'Verificação de telefone',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: RichText(
                  text: TextSpan(
                      text: "Digite o codigo enviado para ",
                      children: [
                        TextSpan(
                            text: widget.telefone,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ],
                      style: const TextStyle(color: Colors.black54, fontSize: 15)),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      obscureText: false,
                      obscuringCharacter: '*',
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v!.length < 3) {
                          return "";
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        inactiveColor: Colors.white,
                        fieldWidth: 40,
                        activeColor: Colors.white,
                        selectedColor: Colors.white,
                        selectedFillColor: Colors.white,
                        disabledColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        activeFillColor:
                            hasError ? Colors.orange : Colors.white,
                      ),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      textStyle: const TextStyle(fontSize: 20, height: 1.6),
                      backgroundColor: Colors.white,
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      boxShadows: const[
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError
                      ? "*Por favor preencha os campos corretamente $error"
                      : "",
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "",
                    style: const TextStyle(color: Colors.black54, fontSize: 15),
                    children: [
                      TextSpan(
                          text: " Reenviar codigo",
                          recognizer: onTapRecognizer,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16))
                    ]),
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    child: const Text("Limpar"),
                    onPressed: () {
                      textEditingController.clear();
                    },
                  ),
                  MaterialButton(
                    child: const Text("Colar"),
                    onPressed: () async {
                      ClipboardData? cdata =
                          await Clipboard.getData(Clipboard.kTextPlain);
                      textEditingController.text = cdata!.text!;
                    },
                  ),
                ],
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
                      onClickVerify();
                    }),
                  ),
                ),
              )
            ],
          )),
    );
  }

  onClickVerify() {
    formKey.currentState!.validate();
    // conditions for validating
    //try {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!, smsCode: currentText);
    auth.signInWithCredential(credential).then((v) async {
      Usuario? u = await setUser();
      if(u!= null) {
        usuarioController.updateUser(u);
        setState(() {
          hasError = false;
         dToast("Numero verificado com sucesso!");
          Future.delayed(const Duration(seconds: 2)).then((v) {
            abrir(context,const  HomePage());
          });
        });
      }

    }).catchError((err) {
      errorController
          .add(ErrorAnimationType.shake); // Triggering error shake animation
      setState(() {
        hasError = true;
        error = '\n ${err.toString()}';
      });
    });
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
