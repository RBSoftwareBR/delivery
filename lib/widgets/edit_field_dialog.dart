
import 'package:delivery/helpers/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

import 'action_button.dart';
import 'input_field.dart';

// ignore: must_be_immutable
class EditFieldDialog extends StatefulWidget {
  String field;
  String content;
  EditFieldDialog(this.field, this.content, {Key? key}) : super(key: key);

  @override
  _EditFieldDialogState createState() {
    // ignore: no_logic_in_create_state
    return _EditFieldDialogState(field, content);
  }
}

class _EditFieldDialogState extends State<EditFieldDialog> {
  String field;
  String content;

  _EditFieldDialogState(this.field, this.content);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isCPFSelected=false;
  bool done = false;
  bool isCPFOrCNPJ = false;
  // ignore: prefer_typing_uninitialized_variables
  var tec;
  @override
  Widget build(BuildContext context) {
    if (!done) {
      tec = TextEditingController(text: content);
      if (field == 'CPF') {
        isCPFSelected = true;
        tec = MaskedTextController(text: content, mask: '000.000.000-00');
        isCPFOrCNPJ = true;
      }
      if (field == 'Telefone') {
        tec = MaskedTextController(text: content, mask: '(00) 0 0000-0000');
      }
      if (field == 'Data de nascimento') {
        tec = MaskedTextController(text: content, mask: '00/00/0000');
      }
      done = true;
    }
    return AlertDialog(
      shape: dialogShape,
      actionsPadding: const  EdgeInsets.all(8),
      title: Text("Editar $field"),
      content: isCPFOrCNPJ
          ? Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          sb,
          inputField(
            keyboardType: field == 'CPF'
                ? TextInputType.number
                : field == 'Email'
                ? TextInputType.emailAddress
                : TextInputType.text,
            controller: tec,
            context: context, unableBorderColor: Colors.black,
            radius: 20,
            borderColor: corPrimaria,
            label:field,
          ),
        ],
      )
          : inputField(
        unableBorderColor: Colors.black,
        keyboardType: field == 'CPF'
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
  }
}
