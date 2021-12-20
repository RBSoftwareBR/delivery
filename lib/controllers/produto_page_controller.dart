import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:delivery/models/produto_model.dart';

import 'package:rxdart/rxdart.dart';
class ProdutoPageController extends BlocBase{
  BehaviorSubject<Produto> controllerProduto = BehaviorSubject<Produto>();
  Stream<Produto> get outProduto => controllerProduto.stream;
  Sink<Produto> get inProduto => controllerProduto.sink;
  Produto produto;

  ProdutoPageController(this.produto){
    inProduto.add(produto);
  }

  @override
  void dispose() {
    controllerProduto.close();
    super.dispose();
  }
}