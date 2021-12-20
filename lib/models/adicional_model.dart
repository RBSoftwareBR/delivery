import 'opcao_model.dart';

class Adicional {
  List<Opcao> opcoes;
  bool isObrigatorio;
  int numOpcoesMax;
  int numOpcoesMin;
  String titulo;

  Adicional(
      {required this.opcoes,
      required this.isObrigatorio,
      this.numOpcoesMax = 0,
      this.numOpcoesMin = 0,
      required this.titulo});

  Map<String, dynamic> toMap() {
    return {
      'opcoes': opcoes.map((map) => map.toMap()).toList(),
      'isObrigatorio': isObrigatorio,
      'num_opcoes_max': numOpcoesMax,
      'num_opcoes_min': numOpcoesMin,
      'titulo': titulo,
    };
  }

  factory Adicional.fromMap(dynamic map) {
    return Adicional(
      opcoes: map.map((map) => Opcao.fromMap(map)).toList(),
      isObrigatorio: (map['isObrigatorio'] is bool
          ? map['isObrigatorio']
          : (map['isObrigatorio'] is num
              ? 0 != map['isObrigatorio'].toInt()
              : ('true' == map['isObrigatorio'].toString()))),
      numOpcoesMax: map['num_opcoes_max']== null? 0: int.parse(map['num_opcoes_max']),
      numOpcoesMin: map['num_opcoes_min']== null? 0: int.parse(map['num_opcoes_min']),
      titulo: map['titulo'].toString(),
    );
  }
}
