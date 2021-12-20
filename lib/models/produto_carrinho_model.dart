import 'package:delivery/models/produto_model.dart';

import 'adicional_model.dart';
import 'opcao_model.dart';

class ProdutoCarrinho {
  String? id;
  Produto produto;
  int quantidade;
  String? obs;
  DateTime dataInserido;
  ProdutoCarrinho(
      {this.id,
      required this.produto,
      required this.quantidade,
      this.obs,
      required this.dataInserido});
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "produto": produto.toMap(),
      "quantidade": quantidade,
      'obs': obs,
      'data_inserido': dataInserido.millisecondsSinceEpoch,
    };
  }

  factory ProdutoCarrinho.fromMap(Map<String, dynamic> json) {
    return ProdutoCarrinho(
        id: json["id"],
        produto: Produto.fromMap(json["produto"]),
        quantidade: int.parse(json["quantidade"].toString()),
        obs: json['obs'],
        dataInserido:
            DateTime.fromMillisecondsSinceEpoch(json['data_inserido']));
  }


  double totalProduto() {
    var preco = produto.preco;
    if (produto.adicionais != null) {
      for (Adicional a in produto.adicionais!) {
        for (Opcao o in a.opcoes) {
          if (o.isSelected) {
            preco += o.preco;
          }
        }
      }
    }
    preco = preco*quantidade;
    return preco;
  }
  double totalUnitario() {
    var preco = produto.preco;
    if (produto.adicionais != null) {
      for (Adicional a in produto.adicionais!) {
        for (Opcao o in a.opcoes) {
          if (o.isSelected) {
            preco += o.preco;
          }
        }
      }
    }
    preco = preco;
    return preco;
  }

}
