
import 'endereco_model.dart';

class Usuario {
  String id;
  String? nome;
  String? email;
  String? foto;
  String? telefone;
  bool notificacoes;
  int permissao;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;
  Endereco? endereco;


  @override
  String toString() {
    return 'Usuario{id: $id, nome: $nome, email: $email, foto: $foto, telefone: $telefone, notificacoes: $notificacoes, permissao: $permissao, created_at: $createdAt, updated_at: $updatedAt, deleted_at: $deletedAt, endereco: $endereco}';
  }

  Usuario(
      {required this.id,
      this.nome,
      this.email,
      this.foto,
      this.telefone,
      required this.notificacoes,
      required this.permissao,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      this.endereco});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'foto': foto,
      'telefone': telefone,
      'notificacoes': notificacoes,
      'permissao': permissao,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
      'deleted_at': deletedAt == null? null: deletedAt!.millisecondsSinceEpoch,
      'endereco': endereco == null? null: endereco!.toMap(),
    };
  }

  factory Usuario.fromMap(dynamic map) {
    return Usuario(
      id: map['id'].toString(),
      nome: map['nome'].toString(),
      email: map['email'].toString(),
      foto: map['foto'].toString(),
      telefone: map['telefone'].toString(),
      notificacoes: map['notificacoes'],
      permissao:map['permissao'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
      deletedAt: map['deleted_at'] == null? null: DateTime.fromMillisecondsSinceEpoch(map['deleted_at']),
      endereco:map['endereco'] == null? null: Endereco.fromMap(map['endereco']),
    );
  }
}
