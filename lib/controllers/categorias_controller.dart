import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:delivery/helpers/constants.dart';
import 'package:delivery/helpers/helper.dart';
import 'package:delivery/models/categoria_model.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class CategoriasController extends BlocBase {
  final String code = 'Categorias Controller';
  BehaviorSubject<List<Categoria>?> categoriasController =
  BehaviorSubject<List<Categoria>?>();
  Stream<List<Categoria>?> get outCategorias => categoriasController.stream;
  Sink<List<Categoria>?> get inCategorias => categoriasController.sink;
  String endPoint = 'categorias/';
  List<Categoria> categorias = [];
  CategoriasController();

  buscarCategoriaPorId(String id) {
    String url = baseApi + endPoint + 'get/$id';
    return http
        .get(
      Uri.parse(url),
    )
        .then((v) {
      var j = json.decode(v.body);
      for (var v in j) {
        try {
          return Categoria.fromMap(v);

        } catch (err) {
          onError(err, code);
        }
      }
    }).catchError((err) {
      onError(err, code);
    });
  }

  buscarCategorias() {
    String url = baseApi + endPoint + 'get/all';
    categorias = [];
    http
        .get(
      Uri.parse(url),
    )
        .then((v) {
      var j = json.decode(v.body);
      for (var v in j) {
        try {
          Categoria p = Categoria.fromMap(v);
          categorias.add(p);
        } catch (err) {
          onError(err, code);
        }
      }
      inCategorias.add(categorias);
    }).catchError((err) {
      onError(err, code);
    });
  }

  Future<bool> cadastrarCategoria(Categoria c) {
    String url = baseApi + endPoint + 'add';
    return http
        .post(Uri.parse(url), body: json.encode(c.toMap()))
        .then((v) {
      return true;
    }).catchError((err) {
      onError(err, code);
      return false;
    });
  }

  Future<bool> editarCategoria(Categoria p) {
    String url = baseApi + endPoint + 'edit';
    return http
        .post(Uri.parse(url), body: p.toMap())
        .then((v) {
      return true;
    }).catchError((err) {
      onError(err, code);
      return false;
    });
  }

  Future<bool> deletarCategoria(Categoria p) {
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

  void filtrarCategorias(String text) {
    List<Categoria> categoriasFiltradas = [];
    for (var i in categorias) {
      if (i.nome.contains(text)) {
        categoriasFiltradas.add(i);
      }
    }
    inCategorias.add(categoriasFiltradas);
  }
}
