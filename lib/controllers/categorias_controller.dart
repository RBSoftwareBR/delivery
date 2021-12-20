import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:delivery/helpers/constants.dart';
import 'package:delivery/helpers/helper.dart';
import 'package:delivery/models/categoria_model.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class CategoriasController extends BlocBase {
  final String code = 'Categorias Controller';
  BehaviorSubject<List<Categoria>> categoriasController =
  BehaviorSubject<List<Categoria>>();
  Stream<List<Categoria>> get outCategorias => categoriasController.stream;
  Sink<List<Categoria>> get inCategorias => categoriasController.sink;
  String endPoint = 'categorias/';
  List<Categoria> categorias = [];
  CategoriasController();

  BuscarCategoriaPorId(String id) {
    String url = baseApi + endPoint + 'get/$id';
    print("AQUI URL ${url}");
    return http
        .get(
      Uri.parse(url),
    )
        .then((v) {
      var j = json.decode(v.body);
      for (var v in j) {
        try {
          return Categoria.fromJson(v);

        } catch (err) {
          onError(err, code);
          print('Erro ao converter Categoria ${v}');
        }
      }
    }).catchError((err) {
      onError(err, code);
    });
  }

  BuscarCategorias() {
    String url = baseApi + endPoint + 'get/all';
    print("AQUI URL ${url}");
    categorias = [];
    http
        .get(
      Uri.parse(url),
    )
        .then((v) {
      var j = json.decode(v.body);
      for (var v in j) {
        try {
          Categoria p = Categoria.fromJson(v);
          categorias.add(p);
        } catch (err) {
          onError(err, code);
          print('Erro ao converter Categoria ${v}');
        }
      }
      inCategorias.add(categorias);
    }).catchError((err) {
      onError(err, code);
    });
  }

  Future<bool> CadastrarCategoria(Categoria c) {
    String url = baseApi + endPoint + 'add';
    print('Iniciando Cadastrar ${url}');
    print("AQUI JSON ${json.encode(c.toJson())}");
    return http
        .post(Uri.parse(url), body: c.toJson())
        .then((v) {
      print("AQUI RESPOSTA ${v.body}");
      return true;
    }).catchError((err) {
      onError(err, code);
      return false;
    });
  }

  Future<bool> EditarCategoria(Categoria p) {
    //TODO FAZER O ENDPOINT
    String url = baseApi + endPoint + 'edit';
    return http
        .post(Uri.parse(url), body: p.toJson())
        .then((v) {
      print("AQUI RESPOSTA ${v.body}");
      return true;
    }).catchError((err) {
      onError(err, code);
      return false;
    });
  }

  Future<bool> DeletarCategoria(Categoria p) {
    String url = baseApi + endPoint + 'remove/${p.id}';
    return http
        .get(
      Uri.parse(url),
    )
        .then((v) {
      return true;
    }).catchError((err) {
      onError(err, code);
      return false;
    });
  }

  void FiltrarCategorias(String text) {
    List<Categoria> categoriasFiltradas = [];
    for (var i in categorias) {
      if (i.nome.contains(text)) {
        categoriasFiltradas.add(i);
      }
    }
    inCategorias.add(categoriasFiltradas);
  }
}
