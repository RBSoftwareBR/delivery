
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/controllers/categorias_controller.dart';
import 'mocks.dart';

void main() {
  test('Cadastrar Categorias', () async {
    CategoriasController cc = CategoriasController();
    for (var c in categoriasMock) {
      await cc.CadastrarCategoria(c);
    }
  });
}
