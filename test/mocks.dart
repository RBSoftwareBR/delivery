
import '../lib/models/adicional_model.dart';
import '../lib/models/categoria_model.dart';
import '../lib/models/opcao_model.dart';
import '../lib/models/produto_model.dart';

List<Categoria> categoriasMock = [
  Categoria(
      nome: 'Lanches',
      foto:
      'https://cdn.pixabay.com/photo/2015/10/07/17/10/cheeseburger-976467_960_720.png'),
  Categoria(
      nome: 'Bebidas',
      foto:
      'https://w7.pngwing.com/pngs/867/586/png-transparent-fizzy-drinks-non-alcoholic-drink-computer-icons-soft-drink-food-rectangle-drinking-straw.png'),
];
List<Adicional> sanduichesAdicional = [
  Adicional(
      titulo: 'Adicionais',
      opcoes: [
        Opcao(
          nome: 'Bacon',
          preco: 1.00,
          isDefaultSelected: false,
        ),
        Opcao(
          nome: 'Cebola',
          preco: 0.50,
          isDefaultSelected: false,
        ),
        Opcao(
          nome: 'Chedar',
          preco: 2.00,
          isDefaultSelected: false,
        ),
        Opcao(
          nome: 'Ketchup',
          preco: 0.00,
          isDefaultSelected: true,
        ),
        Opcao(
          nome: 'Maionese',
          preco: 0.00,
          isDefaultSelected: false,
        ),
        Opcao(
          nome: 'Hamburguer',
          preco: 2.00,
          isDefaultSelected: false,
        ),
      ],
      numOpcoesMax: 99,
      numOpcoesMin: 0,
      isObrigatorio: false),
];
List<Adicional> sucosAdicional = [
  Adicional(
      titulo: 'Agua ou Leite?',
      opcoes: [
        Opcao(
          nome: 'Agua',
          preco: 0.00,
          isDefaultSelected: true,
        ),
        Opcao(
          nome: 'Leite',
          preco: 1.00,
          isDefaultSelected: true,
        ),
      ],
      numOpcoesMax: 1,
      numOpcoesMin: 1,
      isObrigatorio: true),
];

List<Produto> produtosMock = [
  Produto(
    preco: 6.0,
    titulo: 'X Burguer',
    descricao: 'Pão, Hamburger, Queijo, Presunto, Molho',
    codebar: '11111111',
    categoriaId: '0',
    foto: 'http://static.aproveitaabc.com.br/images/2250_sal-1.png',
    adicionais: sanduichesAdicional,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Produto(
    preco: 7.0,
    titulo: 'X Salada',
    descricao: 'Pão, Salada, Tomate, Hamburger, Queijo, Presunto, Molho',
    codebar: '11111112',
    categoriaId: '0',
    foto: 'http://static.aproveitaabc.com.br/images/2250_sal-1.png',
    adicionais: sanduichesAdicional,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Produto(
    preco: 12.0,
    titulo: 'X Bacon',
    descricao: 'Pão, Salada, Tomate, Hamburger, Queijo, Presunto, Molho, Bacon',
    codebar: '11111113',
    categoriaId: '0',
    foto:
    'https://thumb-cdn.soluall.net/prod/shp_products/sp1280fw/0c64c901-182d-4eca-b260-c28e4e5c8f99/9b1c193d-9b1f-43ce-b6e1-656df83fd637.jpg',
    adicionais: sanduichesAdicional,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Produto(
    preco: 2.53,
    titulo: 'Delivery Cola',
    descricao: 'Bebida Refrigerada',
    codebar: '11111114',
    categoriaId: '0',
    foto:
    'https://png.pngtree.com/element_our/20190528/ourlarge/pngtree-cola-drink-icon-image_1164879.jpg',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Produto(
    preco: 2.53,
    titulo: 'Suco de Laranja',
    descricao: 'Suco feito na hora!',
    codebar: '11111114',
    categoriaId: '1',
    adicionais: sucosAdicional,
    foto:
    'https://w7.pngwing.com/pngs/677/45/png-transparent-lemonade-computer-icons-drink-soft-drink.png',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Produto(
    preco: 2.53,
    titulo: 'Suco de Maracuja',
    descricao: 'Suco feito na hora!',
    codebar: '11111114',
    categoriaId: '1',
    adicionais: sucosAdicional,
    foto:
    'https://w7.pngwing.com/pngs/677/45/png-transparent-lemonade-computer-icons-drink-soft-drink.png',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Produto(
    preco: 6.00,
    titulo: 'Suco abacaxi com hortela',
    descricao: 'Suco feito na hora!',
    codebar: '11111114',
    categoriaId: '1',
    adicionais: sucosAdicional,
    foto:
    'https://w7.pngwing.com/pngs/677/45/png-transparent-lemonade-computer-icons-drink-soft-drink.png',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),Produto(
    preco: 2.53,
    titulo: 'Suco de abacaxi',
    descricao: 'Suco feito na hora!',
    codebar: '11111114',
    categoriaId: '1',
    adicionais: sucosAdicional,
    foto:
    'https://w7.pngwing.com/pngs/677/45/png-transparent-lemonade-computer-icons-drink-soft-drink.png',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),Produto(
    preco: 5.03,
    titulo: 'Refrigerante Kuat',
    descricao: 'Guraraná',
    codebar: '11111114',
    categoriaId: '1',
    adicionais: sucosAdicional,
    foto:
    'https://w7.pngwing.com/pngs/677/45/png-transparent-lemonade-computer-icons-drink-soft-drink.png',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Produto(
    preco: 2.53,
    titulo: 'Coxinha',
    descricao: 'Frito na hora',
    codebar: '11111114',
    categoriaId: '1',
    adicionais: ,
    foto:
    'https://w7.pngwing.com/pngs/677/45/png-transparent-lemonade-computer-icons-drink-soft-drink.png',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];
