import 'dart:convert';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:delivery/helpers/constants.dart';
import 'package:delivery/helpers/helper.dart';
import 'package:delivery/models/produto_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

import 'buscas_controller.dart';

class ProdutosController extends BlocBase {
  final String code = 'Produtos Controller';
  BehaviorSubject<List<Produto>> produtosController =
      BehaviorSubject<List<Produto>>();
  Stream<List<Produto>> get outProdutos => produtosController.stream;
  Sink<List<Produto>> get inProdutos => produtosController.sink;
  String endPoint = 'produtos/';
  List<Produto> produtos = [];
  TextEditingController searchController = TextEditingController();
  ProdutosController();

  String termoDeBusca = '';
  int offset = 0;
  int limitador = 20;
  String? categoriaSelecionada;
  BehaviorSubject<String?> controllerCategoriaSelecionada =
  BehaviorSubject<String?>();
  Stream<String?> get outCategoriaSelecionada => controllerCategoriaSelecionada.stream;
  Sink<String?> get inCategoriaSelecionada => controllerCategoriaSelecionada.sink;
  Future<bool> buscarProdutos({String termo = '', reset = false}) {
    if (!reset) {
      if (termo != termoDeBusca) {
        offset = 0;
        produtos = [];
        inProdutos.add(produtos);
      }
    } else {
      offset = 0;
      produtos = [];
      inProdutos.add(produtos);
    }

    if (termo != '') {
      addToBuscas(
        termo,
      );
    }
    categoriaSelecionada = null;
    termoDeBusca = termo;

    inCategoriaSelecionada.add(categoriaSelecionada);
    String url = baseApi +
        endPoint +
        '${termoDeBusca == '' ? '' : termoDeBusca}/$limitador/$offset';
    return http
        .get(
      Uri.parse(url),
    )
        .then((v) {
      var j = json.decode(v.body);
      for (var v in j) {
        try {
          Produto p = Produto.fromMap(v);
          produtos.add(p);
        } catch (err) {
          onError(err, code);
        }
      }
      inProdutos.add(produtos);
      offset += limitador;
      return true;
    }).catchError((err) {
      onError(err, code);
      return false;
    });
  }

  buscarProdutosPorCategoria(String c, {String termo = '', reset = false}) {
    categoriaSelecionada = c;
    if (!reset) {
      if (termo != termoDeBusca) {
        offset = 0;
        produtos = [];
        inProdutos.add(produtos);
      }
    } else {
      offset = 0;
      produtos = [];
      inProdutos.add(produtos);
    }
    termoDeBusca = termo;
    inCategoriaSelecionada.add(categoriaSelecionada);
    String url = baseApi +
        endPoint +
        'categoria/${termoDeBusca == '' ? '' : termoDeBusca}/$limitador/$offset/$c';
    return http.get(Uri.parse(url)).then((v) {
      var j = json.decode(v.body);
      for (var v in j) {
        try {
          Produto p = Produto.fromMap(v);
          produtos.add(p);
        } catch (err) {
          onError(err, code);
        }
      }
      inProdutos.add(produtos);
      offset += limitador;
      return true;
    }).catchError((err) {
      onError(err, code);
      return false;
    });
  }

  cadastrarProduto(Produto p) {
    String url = baseApi + endPoint + 'add';
    return Dio().post(url, data: p.toMap()).then((v) {
      return true;
    }).catchError((err) {
      onError(err, code);
      return false;
    });
  }

  Future<bool> editarProdutoProduto(Produto p) {
    String url = baseApi + endPoint + 'edit';
    return http.post(Uri.parse(url), body: p.toMap()).then((v) {
      return true;
    }).catchError((err) {
      onError(err, code);
      return false;
    });
  }

  Future<bool> removerProduto(Produto p) {
    p.visivel = false;
    p.deletedAt = DateTime.now();
    String url = baseApi + endPoint + 'edit';
    return http.post(Uri.parse(url), body: p.toMap()).then((v) {
      return true;
    }).catchError((err) {
      onError(err, code);
      return false;
    });
  }
}

late ProdutosController pc;
