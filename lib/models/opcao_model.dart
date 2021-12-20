
import 'adicional_model.dart';

class Opcao {
  String nome;
  double preco;
  bool isSelected;
  bool isDefaultSelected;

  Opcao({required this.nome, this.preco = 0 , this.isSelected= false, required this.isDefaultSelected});

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'preco': preco,
      'isSelected': isSelected,
      'isDefaultSelected': isDefaultSelected,
    };
  }

  factory Opcao.fromMap(dynamic map) {
    return Opcao(
      nome: map['nome'].toString(),
      preco: map['preco'] == null? 0.0 :double.parse(map['preco']),
      isSelected: (map['isSelected'] is bool
              ? map['isSelected']
              : (map['isSelected'] is num
                  ? 0 != map['isSelected'].toInt()
                  : ('true' == map['isSelected'].toString()))),
      isDefaultSelected:  (map['isDefaultSelected'] is bool
              ? map['isDefaultSelected']
              : (map['isDefaultSelected'] is num
                  ? 0 != map['isDefaultSelected'].toInt()
                  : ('true' == map['isDefaultSelected'].toString()))),
    );
  }
}

