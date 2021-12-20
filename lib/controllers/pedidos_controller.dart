import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:delivery/helpers/constants.dart';
import 'package:delivery/helpers/helper.dart';
import 'package:delivery/helpers/references.dart';
import 'package:delivery/models/pedido_model.dart';
import 'package:delivery/models/user_model.dart';

class PedidosController extends BlocBase {
  StreamController<List<Pedido>?> controllerPedidos =
      StreamController<List<Pedido>?>.broadcast();
  Stream<List<Pedido>?> get outPedidos => controllerPedidos.stream;
  Sink<List<Pedido>?> get inPedidos => controllerPedidos.sink;
  List<Pedido>? pedidos;
  PedidosController(Usuario user,) {
    buscar(user,);
  }

  buscar(Usuario usuario) {
    var ref = pedidosRef.where('id_user', isEqualTo: localUser!.id).limit(20).orderBy('hora_enviado',descending: true);
    pedidos = [];
    inPedidos.add(pedidos);
    return ref.snapshots().listen((v) {
      pedidos = [];
      for (var d in v.docs) {
        Pedido p = Pedido.fromMap(d.data());
        p.id = d.id;
        pedidos!.add(p);
      }
      pedidos!.sort((Pedido a, Pedido b) =>
          b.horaEnviado.compareTo(a.horaEnviado));
      inPedidos.add(pedidos);
    }).onError((err) {
      onError(err,'Buscar Pedidos');
    });
  }

  @override
  void dispose() {
    controllerPedidos.close();
    super.dispose();
  }
}