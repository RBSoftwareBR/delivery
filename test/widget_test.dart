
import 'package:delivery/controllers/produtos_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'mocks.dart';

void main() {
  /*test('Cadastrar Categorias', () async {
    CategoriasController cc = CategoriasController();
    for (var c in categoriasMock) {
      var result = await cc.CadastrarCategoria(c);
      assert(result == true);
    }
  });  */
  test('Cadastrar Produtos', () async {
    ProdutosController pc = ProdutosController();
    for (var p in produtosMock) {
      var result = await pc.cadastrarProduto(p);
      assert(result == true);
    }
  });
}
