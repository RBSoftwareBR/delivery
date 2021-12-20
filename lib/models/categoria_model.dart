class Categoria{
  String? id;
  String nome;
  String foto;

  Map<String, dynamic> toJson() {
    return {
      "id":this.id.toString(),
      "nome": this.nome.toString(),
      "foto":this.foto.toString(),
    };
  }



  Categoria({this.id,required this.nome, required this.foto, });

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: json["id"]??  json["id"].toString(),
      nome: json["nome"],
      foto: json["foto"],
    );
  }

}