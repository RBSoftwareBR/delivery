import 'package:delivery/models/produto_carrinho_model.dart';
import 'package:delivery/models/user_model.dart';

class Pedido {
  String? id;
  String formaPagamento;
  double valorTotal;
  DateTime horaEnviado;
  double? trocoPara;
  String idUser;
  Usuario usuario;
  String pdfPath;
  String? bandeira;
  List<ProdutoCarrinho> produtos;
  double valorProdutos;
  String? obs;

  Pedido(
      {required this.formaPagamento,
      required this.valorTotal,
        this.id,
      required this.horaEnviado,
      this.trocoPara,
      required this.idUser,
      required this.usuario,
        required this.pdfPath,
      this.bandeira,
      required this.produtos,
      required this.valorProdutos,
      this.obs});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'forma_pagamento': formaPagamento,
      'valor_total': valorTotal,
      'hora_enviado': horaEnviado.toString(),
      'troco_para': trocoPara,
      'id_user': idUser,
      'usuario': usuario.toMap(),
      'pdf_path':pdfPath,
      'bandeira': bandeira,
      'produtos': produtos.map((map) => map.toMap()).toList(),
      'valor_produtos': valorProdutos,
      'obs': obs,
    };
  }

  factory Pedido.fromMap(dynamic map) {
    return Pedido(
      id: map['id'].toString(),
      formaPagamento: map['forma_pagamento'].toString(),
      valorTotal: double.parse(map['valor_total'].toString()),
      horaEnviado: DateTime.parse(map['hora_enviado'].toString()),
      trocoPara: double.tryParse(map['troco_para'].toString()),
      idUser: map['id_user'].toString(),
        pdfPath:map['pdf_path'],
      usuario: Usuario.fromMap(map['usuario']),
      bandeira: map['bandeira']?.toString(),
      produtos: decodeProdutos(map['produtos']) ,
      valorProdutos: double.parse(map['valor_produtos'].toString()),
      obs: map['obs']?.toString(),
    );
  }
  static List<ProdutoCarrinho> decodeProdutos(var json){
    List<ProdutoCarrinho> produtosTemp = [];
    for(var i in json){
      produtosTemp.add(ProdutoCarrinho.fromMap(i));
    }
    return produtosTemp;
  }
}
