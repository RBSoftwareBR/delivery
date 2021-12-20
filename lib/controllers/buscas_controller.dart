import 'package:delivery/helpers/constants.dart';

List<String> getBuscas(String pattern) {
  List<String> buscas;
  try {
     buscas = sp!.getStringList('buscas')!;
  }catch(err){
    buscas = [];
  }
  buscas.retainWhere((a) => a.toLowerCase().contains(pattern.toLowerCase()));
  buscas = buscas.toSet().toList();
  return buscas;
}

addToBuscas(String pattern) {
  List<String> buscas;
  try {
    buscas = sp!.getStringList('buscas')!;
  }catch(err){
    buscas = [];
  }

  buscas.add(pattern);
  sp!.setStringList('buscas', buscas);
}
