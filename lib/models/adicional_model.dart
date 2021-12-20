import 'package:delivery/helpers/helper.dart';

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
      opcoes:decodeOpcoes(map['opcoes']),
      isObrigatorio: (map['isObrigatorio'] is bool
          ? map['isObrigatorio']
          : (map['isObrigatorio'] is num
              ? 0 != map['isObrigatorio'].toInt()
              : ('true' == map['isObrigatorio'].toString()))),
      numOpcoesMax: map['num_opcoes_max']== null? 0: int.parse(map['num_opcoes_max'].toString()),
      numOpcoesMin: map['num_opcoes_min']== null? 0: int.parse(map['num_opcoes_min'].toString()),
      titulo: map['titulo'].toString(),
    );
  }

  static List<Opcao>  decodeOpcoes(var opcoes){
    List<Opcao> opcionaisTemp = [];
    for(var j in opcoes){
      try{
        opcionaisTemp.add(Opcao.fromMap(j));
      }catch(err){
        onError(err,'Produto From Json');
      }
    }
    return opcionaisTemp;
  }
}
