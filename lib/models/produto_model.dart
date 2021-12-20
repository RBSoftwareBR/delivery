import 'adicional_model.dart';

class Produto {
  String? id;
  String titulo;
  String descricao;
  String codebar;
  String categoriaId;
  String? foto;
  double preco;
  bool visivel;
  List<Adicional>? adicionais;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;


  Produto(
      {this.id,
      required this.titulo,
      required this.descricao,
      required this.codebar,
      required this.categoriaId,
      this.foto,
      required this.preco,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      this.adicionais,
      this.visivel = true});

  @override
  String toString() {
    return 'Produto{id: $id, titulo: $titulo, descricao: $descricao, codebar: $codebar, categoriaId: $categoriaId, foto: $foto, preco: $preco, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, adicionais: $adicionais}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'codebar': codebar,
      'categoria_id': categoriaId,
      'foto': foto,
      'preco': preco,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
      'deleted_at': deletedAt?.millisecondsSinceEpoch,
      'visivel': visivel,
      'adicionais': adicionais?.map((map) => map.toMap()).toList() ?? [],
    };
  }

  factory Produto.fromMap(dynamic map) {
    return Produto(
      id: map['id'].toString(),
      titulo: map['titulo'].toString(),
      descricao: map['descricao'].toString(),
      codebar: map['codebar'].toString(),
      categoriaId: map['categoriaId'].toString(),
      foto: map['foto']?.toString(),
      preco: (map['preco'] is num
          ? map['preco'].toDouble()
          : double.tryParse(map['preco'])),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
      deletedAt: map['deleted_at'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['deleted_at']),
      visivel: map['visivel'],
      adicionais: map['adicionais'] == null
          ? null
          : map['adicionais'].map((map) => Adicional.fromMap(map)).toList(),
    );
  }
}
