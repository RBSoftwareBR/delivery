import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:delivery/helpers/constants.dart';
import 'package:delivery/helpers/helper.dart';
import 'package:delivery/helpers/references.dart';
import 'package:delivery/helpers/toast.dart';
import 'package:delivery/models/carrinho_model.dart';
import 'package:delivery/models/produto_carrinho_model.dart';
import 'package:rxdart/rxdart.dart';

class CarrinhoController extends BlocBase {
  final String code = 'Carrinho Controller';
  Carrinho? carrinho;
  BehaviorSubject<List<ProdutoCarrinho>> carrinhoController =
      BehaviorSubject<List<ProdutoCarrinho>>();
  Stream<List<ProdutoCarrinho>> get outCarrinho => carrinhoController.stream;
  Sink<List<ProdutoCarrinho>> get inCarrinho => carrinhoController.sink;

  int get quantidadeProdutos {
    int quantidade = 0;
    if (carrinho != null) {
      for (var i in carrinho!.produtos!) {
        int qtd = i.quantidade;
        quantidade += qtd;
      }
    }
    return quantidade;
  }

  double get total {
    double total = 0;
    if (carrinho != null) {
      for (ProdutoCarrinho i in carrinho!.produtos!) {
        total += i.totalProduto();
      }
    }
    return total;
  }



  CarrinhoController() {
    if (localUser != null) {
      carrinhosRef
          .doc('User${localUser!.id}')
          .snapshots()
          .listen((value) {
        if (value.data() == null) {
          carrinho = Carrinho(
              user: localUser!,
              nome: localUser!.nome,
              usuario: localUser!.id.toString(),
              deletedAt: DateTime.now(),
              updatedAt: DateTime.now(),
              isPublic: false,
              produtos: <ProdutoCarrinho>[],
              numItens: 0);
          carrinhosRef.doc('User${localUser!.id}').set(carrinho!.toMap());
          inCarrinho.add(carrinho!.produtos!);
        } else {
          carrinho = Carrinho.fromMap(value.data());
          inCarrinho.add(carrinho!.produtos!);
        }
      });
    }
  }

  Future<bool> adicionarProduto(ProdutoCarrinho pp) {
    if(localUser == null){
      dToast('Ops!, é nescessario fazer login para efetuar está ação');
      return Future.value(false);
    }
    if (carrinho!.produtos == null) {
      carrinho!.produtos = [];
    }
    carrinho!.produtos!.add(pp);
    return carrinhosRef
        .doc('User${localUser!.id}')
        .set(carrinho!.toMap())
        .then((v) {
      return true;
    }).catchError((err) {
      onError(err, code);
      return false;
    });
  }

  Future<bool> updateProduto(ProdutoCarrinho pp) {
    List<ProdutoCarrinho> produtosTemp = [];
    for (var p in carrinho!.produtos!) {
        if (p.dataInserido.millisecondsSinceEpoch ==
            pp.dataInserido.millisecondsSinceEpoch) {
          produtosTemp.add(pp);
        } else {
          produtosTemp.add(p);
        }
    }
    carrinho!.produtos = produtosTemp;
    return carrinhosRef
        .doc('User${localUser!.id}')
        .set(carrinho!.toMap())
        .then((v) {
      return true;
    }).catchError((err) {
      onError(err, code);
      return false;
    });
  }

  Future<bool> removerProduto(ProdutoCarrinho pp) {
    List<ProdutoCarrinho> produtosTemp = [];
    for (var p in carrinho!.produtos!) {
        if (p.dataInserido ==
            pp.dataInserido) {
        } else {
          produtosTemp.add(p);
        }
    }
    carrinho!.produtos = produtosTemp;
    return carrinhosRef
        .doc('User${localUser!.id}')
        .set(carrinho!.toMap())
        .then((v) {
      return true;
    }).catchError((err) {
      onError(err, code);
      return false;
    });
  }

  Future<bool> deletarCarrinho() {
    return carrinhosRef
        .doc('User${localUser!.id}')
        .delete()
        .then((v) {
      return true;
    }).catchError((err) {
      onError(err, code);
      return false;
    });
  }
}

late CarrinhoController carrinhoController;
