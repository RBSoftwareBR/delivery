import 'dart:convert';
import 'package:delivery/helpers/helper.dart';
import 'package:delivery/models/produto_carrinho_model.dart';
import 'package:delivery/models/user_model.dart';

class Carrinho {
  bool isPublic;
  String usuario;
  Usuario user;
  int numItens;
  DateTime? createdAt, updatedAt,deletedAt;
  List<ProdutoCarrinho>? produtos;
  String? nome;

  Carrinho(
      {this.isPublic = false,
      required this.usuario,
      this.deletedAt,
      this.numItens = 0,
      this.updatedAt,
      this.createdAt,
      required this.user,
      this.produtos,
      this.nome});

  Map<String, dynamic> toMap() {
    List l = [];
    for (ProdutoCarrinho ppt in produtos!) {
      l.add(ppt.toMap());
    }
    return {
      "isPublic": isPublic,
      "usuario": usuario,
      'user': user.toMap(),
      'num_itens': numItens,
      "created_at":
          deletedAt == null ? null : deletedAt!.millisecondsSinceEpoch,
      "updated_at":
          updatedAt == null ? null : updatedAt!.millisecondsSinceEpoch,
      "deleted_at":
          createdAt == null ? null : createdAt!.millisecondsSinceEpoch,
      "produtos": l,
      "nome": nome,
    };
  }

  static getProdutosList(j) {
    List<ProdutoCarrinho> produtos = [];
    try {
      j = json.decode(j);
    } catch (err) {
      onError(err, 'Carrinho From Map');
    }
    for (var i in j) {
      ProdutoCarrinho ppt = ProdutoCarrinho.fromMap(i);

      produtos.add(ppt);
    }
    return produtos;
  }

  factory Carrinho.fromMap(map) {
    return Carrinho(
      isPublic: map['isPublic'] as bool,
      usuario: map['usuario'] as String,
      nome: map['nome'],
      numItens: map['num_itens'] as int,
      user: Usuario.fromMap(map['user']),
      deletedAt: map["created_at"] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map["created_at"]),
      updatedAt: map["updated_at"] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map["updated_at"]),
      createdAt: map["deleted_at"] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map["deleted_at"]),
      produtos: getProdutosList(map['produtos']),
    );
  }
}
