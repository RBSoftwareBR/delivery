import 'package:delivery/controllers/carrinho_controller.dart';
import 'package:delivery/helpers/helper.dart';
import 'package:delivery/helpers/references.dart';
import 'package:delivery/helpers/styles.dart';
import 'package:delivery/helpers/toast.dart';
import 'package:delivery/models/pedido_model.dart';
import 'package:delivery/pages/pedidos/pedido_details_page.dart';
import 'package:delivery/widgets/h_text.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:rive/rive.dart';

// ignore: must_be_immutable
class PaymentAnimation extends StatefulWidget {
  Pedido pedido;
  final String code = 'Payment Animation';
  PaymentAnimation(
    this.pedido, {Key? key}
  ) : super(key: key);

  @override
  _PaymentAnimationState createState() => _PaymentAnimationState();
}

class _PaymentAnimationState extends State<PaymentAnimation> {
  // ignore: unused_field
  late RiveAnimationController _controller;
  late String id;
  @override
  void initState() {
    super.initState();
    id = DateTime.now().millisecondsSinceEpoch.toString();
    finalizarPedido(widget.pedido).then((v) {
      Future.delayed(const  Duration(seconds: 5)).then((_) {
        if (v != null) {
          direcionarUsuario(v);
        } else {
          fechar(context, widget.code);
        }
      });
    });
  }

  bool isPayed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: isPayed
              ? const Icon(
                  Mdi.checkCircle,
                  size: 40,
                  color: corPrimaria,
                )
              : const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(
                    color: corPrimaria,
                    strokeWidth: 10,
                  ),
                ),
        ),
        sb,
        hText(!isPayed ? 'Enviando Pedido' : 'Pedido realizado', context,
            color: Colors.grey, size: 22)
      ],
    )));
  }

  Future<Pedido?> finalizarPedido(Pedido pedido) async {
    //TODO GERAR E SALVAR PDF;
    pedido.id = id;

    return pedidosRef.doc(id).set(pedido.toMap()).then((v) async {
      return Future.delayed(const Duration(seconds: 2)).then((v) {
        try {
          setState(() {
            isPayed = true;
            _controller = SimpleAnimation('play');
          });
        } catch (err) {
          onError(err,widget.code);
        }
        return pedido;
      });
    }).catchError((err) {
      dToast("Erro ao Efetuar Pedido, tente novamente");
    });
  }

  direcionarUsuario(Pedido pedido) {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    abrir(
        context,
        PedidoDetailsPage(
          pedido,
        ));
    try {
      carrinhoController.deletarCarrinho();
    } catch (err) {
      onError(err, widget.code);
    }
  }
}
