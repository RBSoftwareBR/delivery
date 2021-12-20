import 'package:delivery/helpers/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BandeiraListItem extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var bandeira;
  BandeiraListItem(this.bandeira, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(11.0),
        child:Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,border: Border.all(color:Colors.grey)
            ),
            height: 50,
            child: Row(
              children: [
                sb,
                Container(
                    width: 40,
                    height: 30,
                    color: bandeira['nome'] == 'Vr Alimentação'
                        ? Colors.green
                        : bandeira['nome'] == 'Vr Refeição'
                        ? Colors.green
                        : bandeira['nome'] == 'Banese Card'
                        ? Colors.green[750]
                        : bandeira['nome'] == 'American Express'
                        ? Colors.blue[700]
                        : bandeira['nome'] == 'Vale Gás'
                        ? Colors.blue
                        : Colors.white,
                    child: Image.asset(
                      bandeira['imagem'],
                      fit: BoxFit.contain,
                    )),
                sb,
                const  SizedBox(width: 5),
                Text(
                  bandeira['nome'],
                  style: const  TextStyle(
                    fontFamily: 'Made',
                    fontSize: 22,
                    color: Colors.grey,
                  ),
                )
              ],
            )));
  }
}
