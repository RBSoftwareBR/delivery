class Categoria{
  String? id;
  String nome;
  String foto;

  Map<String, dynamic> toMap() {
    return {
      "id":id.toString(),
      "nome": nome.toString(),
      "foto":foto.toString(),
    };
  }



  Categoria({this.id,required this.nome, required this.foto, });

  factory Categoria.fromMap(Map<String, dynamic> json) {
    return Categoria(
      id: json["id"].toString(),
      nome: json["nome"],
      foto: json["foto"],
    );
  }

}