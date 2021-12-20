

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:delivery/helpers/constants.dart';
import 'package:delivery/models/user_model.dart';
import 'package:rxdart/rxdart.dart';
class PagamentoController implements BlocBase {
  String? formaPagamento;

  BehaviorSubject<String> controllerFormaPagamento =
      BehaviorSubject<String>();
  Stream<String> get outFormaPagamento => controllerFormaPagamento.stream;
  Sink<String> get inFormaPagamento => controllerFormaPagamento.sink;
  Usuario usuario = localUser!;

  PagamentoController();


  @override
  void dispose() {
  }

  @override
  void addListener(listener) {}

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {}

  @override
  void removeListener(listener) {}
}
