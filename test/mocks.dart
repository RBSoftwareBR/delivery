


import 'package:delivery/models/adicional_model.dart';
import 'package:delivery/models/categoria_model.dart';
import 'package:delivery/models/produto_model.dart';
import 'package:delivery/models/opcao_model.dart';

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
List<Adicional> salgadosAdicional = [
  Adicional(
      titulo: 'Assado ou Frito?',
      opcoes: [
        Opcao(
          nome: 'assado',
          preco: 0.00,
          isDefaultSelected: true,
        ),
        Opcao(
          nome: 'Frito',
          preco: 1.00,
          isDefaultSelected: true,
        ),
      ],
      numOpcoesMax: 1,
      numOpcoesMin: 1,
      isObrigatorio: true),
];
List<Adicional> pastelAdicional = [
  Adicional(
      titulo: ' Doce ou Salgado?',
      opcoes: [
        Opcao(
          nome: 'Doce',
          preco: 0.00,
          isDefaultSelected: true,
        ),
        Opcao(
          nome: 'Salgado',
          preco: 1.00,
          isDefaultSelected: true,
        ),
      ],
      numOpcoesMax: 1,
      numOpcoesMin: 1,
      isObrigatorio: true),
];List<Adicional> tortaAdicional = [
  Adicional(
      titulo: ' Doces ou Salgada?',
      opcoes: [
        Opcao(
          nome: 'Doces',
          preco: 0.00,
          isDefaultSelected: true,
        ),
        Opcao(
          nome: 'Salgada',
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
  ),Produto(
    preco: 5.0,
    titulo: 'Coxinha',
    descricao: 'frango, frango com catupiri',
    codebar: '11111113',
    categoriaId: '0',
    foto:
    'https://media.gazetadopovo.com.br/2019/11/12173310/Texto-3-.-coxinha-pelanda.jpeg',
    adicionais: sanduichesAdicional,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),Produto(
    preco: 5.0,
    titulo: 'Pão de queijo',
    descricao: 'pão de queijo',
    codebar: '11111113',
    categoriaId: '0',
    foto:
    'https://paodequeijoecia.com.br/wp-content/uploads/2019/03/paodequeijo.jpg',
    adicionais: sanduichesAdicional,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),Produto(
    preco: 5.0,
    titulo: 'kibe',
    descricao: 'carne moida',
    codebar: '11111113',
    categoriaId: '0',
    foto:
    'https://midiamax.uol.com.br/media/_versions/kibe_frito_widexl.jpg',
    adicionais: salgadosAdicional,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),Produto(
    preco: 7.0,
    titulo: 'Sfiha',
    descricao: 'Tomate, Queijo, Presunto, Champion',
    codebar: '11111113',
    categoriaId: '0',
    foto:
    'https://1.bp.blogspot.com/-_K6e6H4SKVc/X2qrBCpGOMI/AAAAAAAAdG8/s1sZd-qqjxs66H6Df5cF7o0-zHgeyQWdgCNcBGAsYHQ/w1200-h630-p-k-no-nu/esfiha%2Barabe%2Bfechada.jpg',
    adicionais: salgadosAdicional,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),Produto(
    preco: 7.0,
    titulo: 'Calzone',
    descricao: 'Queijo, Presunto, carne moida, tomate',
    codebar: '11111113',
    categoriaId: '0',
    foto:
    'https://i.pinimg.com/originals/d3/e5/eb/d3e5ebe97c6963cff9a6f368b98a81ea.jpg',
    adicionais: salgadosAdicional,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),Produto(
    preco: 10.0,
    titulo: 'Empadão',
    descricao: 'Frango, Palmito, Tomate, azeitona',
    codebar: '11111113',
    categoriaId: '0',
    foto:
    'https://i.pinimg.com/originals/d3/e5/eb/d3e5ebe97c6963cff9a6f368b98a81ea.jpg',
    adicionais: salgadosAdicional,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),Produto(
    preco: 6.0,
    titulo: 'Pastel',
    descricao: 'Queijo, Presunto, carne moida, tomate, frango, Chocolate, nutella, morango, ninho, banana, ',
    codebar: '11111113',
    categoriaId: '0',
    foto:
    'https://i.pinimg.com/736x/f0/1b/7f/f01b7f34c916775d02a3b93e82cacf75--fds-festival.jpg',
    adicionais: pastelAdicional,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),Produto(
    preco: 6.0,
    titulo: 'Pastel',
    descricao: 'Queijo, Presunto, carne moida, tomate, frango, Chocolate, nutella, morango, ninho, banana, ',
    codebar: '11111113',
    categoriaId: '0',
    foto:
    'https://i.pinimg.com/736x/f0/1b/7f/f01b7f34c916775d02a3b93e82cacf75--fds-festival.jpg',
    adicionais: pastelAdicional,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ), Produto(
    preco: 10.0,
    titulo: 'Empada',
    descricao: 'Queijo, Presunto, carne moida, tomate, frango, Chocolate, nutella, morango, ninho, banana, ',
    codebar: '11111113',
    categoriaId: '0',
    foto:
    'https://www.anamariabrogui.com.br/assets/uploads/receitas/fotos/usuario-2547-5a5dd5ffb4970d730e1ea16f220a0cd7.jpg',
    adicionais: pastelAdicional,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Produto(
    preco: 10.0,
    titulo: 'Quiche',
    descricao: 'Queijo, Presunto, carne moida, tomate, frango, ',
    codebar: '11111113',
    categoriaId: '0',
    foto:
    'http://d2r9epyceweg5n.cloudfront.net/stores/001/136/636/products/padaria-quiche-und-100g-3-queijos1-8ca80faf51e7bd9eb315953553858232-640-0.jpeg',
    adicionais: salgadosAdicional,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),

  Produto(
    preco: 12.0,
    titulo: 'Torta de morango',
    descricao: 'Morango ',
    codebar: '11111113',
    categoriaId: '0',
    foto:
    'https://www.anamariabrogui.com.br/assets/uploads/receitas/fotos/usuario-2439-25d257dbf67b1b7af398b2024a97345a.png',
    adicionais: tortaAdicional,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),Produto(
    preco: 12.0,
    titulo: 'Torta de Maracujá',
    descricao: 'Maracuja ',
    codebar: '11111113',
    categoriaId: '0',
    foto:
    'https://moinhoglobo.com.br/wp-content/uploads/2020/04/tortinha.png',
    adicionais: tortaAdicional,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),Produto(
    preco: 12.0,
    titulo: 'Torta Cheescake de frutas vermelhas',
    descricao: 'morango, cereja, mirtilo, framboesa, amora, acerola,  ',
    codebar: '11111113',
    categoriaId: '0',
    foto:
    'https://img.cybercook.com.br/imagens/receitas/35/cheesecake-de-frutas-vermelhas-3.jpeg',
    adicionais: tortaAdicional,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),Produto(
    preco: 12.0,
    titulo: 'Torta Ninho com avelã',
    descricao: 'Ninho com creme de avelã, ',
    codebar: '11111113',
    categoriaId: '0',
    foto:
    'https://cdn.awsli.com.br/1000x1000/252/252686/produto/43922227/faf960cced.jpg',
    adicionais: tortaAdicional,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),Produto(
    preco: 12.0,
    titulo: 'Torta de damasco com nozes',
    descricao: 'damasco, nozes, ameixa ',
    codebar: '11111113',
    categoriaId: '0',
    foto:
    'http://f.i.uol.com.br/folha/comida/images/12276649.jpeg',
    adicionais: tortaAdicional,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),Produto(
    preco: 12.0,
    titulo: 'torta de Limão ',
    descricao: 'limão ',
    codebar: '11111113',
    categoriaId: '0',
    foto:
    'https://img.itdg.com.br/images/recipes/000/104/383/319681/319681_original.jpg',
    adicionais: tortaAdicional,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),Produto(
    preco: 8.0,
    titulo: 'Misto quente',
    descricao: 'Queijo, Presunto, pão, ',
    codebar: '11111113',
    categoriaId: '0',
    foto:
    'https://www.pifpaf.com.br/wp-content/uploads/2016/01/Misto-quente.jpg',
    adicionais: sanduichesAdicional,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),Produto(
    preco: 6.0,
    titulo: 'X-Italiano',
    descricao: 'Queijo, Presunto, frango, alface, tomate, salame, maionese e hamburger ',
    codebar: '11111113',
    categoriaId: '0',
    foto:
    'https://assets.unileversolutions.com/recipes-v2/106684.jpg',
    adicionais: sanduichesAdicional,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),Produto(
    preco: 18.0,
    titulo: 'Union',
    descricao: 'Queijo, 160gr de hamburger, cheddar, bacon, anéis de cebola, barbecue e maionese, ',
    codebar: '11111113',
    categoriaId: '0',
    foto:
    'https://media-cdn.tripadvisor.com/media/photo-s/06/a8/1f/0f/union-burger.jpg',
    adicionais: sanduichesAdicional,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),Produto(
    preco: 17.0,
    titulo: 'Pepper',
    descricao: 'Hamburger 160gr, cheddar, bacon, tomate, picles, pasta de pimemta ',
    codebar: '11111113',
    categoriaId: '0',
    foto:
    'http://assets.kraftfoods.com/recipe_images/opendeploy/60766_640x428.jpg',
    adicionais: sanduichesAdicional,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),Produto(
    preco: 19.0,
    titulo: 'Tsunami',
    descricao: 'Pão, 2 hamburger, queijo, bacon, catupiry, ovo, milho, alface, tomate e maionese ',
    codebar: '11111113',
    categoriaId: '0',
    foto:
    'https://barbossauruguaiana.com.br/uploads/produtos/thumbs/15936341725efced7c10fb8-burguer-tsunami.jpg',
    adicionais: sanduichesAdicional,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),Produto(
    preco: 14.0,
    titulo: 'Shawarmas de Carne, ',
    descricao: 'carne Bovina,alface, picles, molho de alho, batata frita e pão sirio  ',
    codebar: '11111113',
    categoriaId: '0',
    foto:
    'https://i.ytimg.com/vi/gi_0owiTY7c/maxresdefault.jpg',
    adicionais: sanduichesAdicional,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),Produto(
    preco:12.0,
    titulo: 'Shawarma de frango',
    descricao: 'carne de frango,alface, picles, molho de alho, batata frita e pão sirio',
    codebar: '11111113',
    categoriaId: '0',
    foto:
    'https://seurachid.com.br/vila-romana/wp-content/uploads/2016/05/Shawarma-De-Frango.jpg',
    adicionais: sanduichesAdicional,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),Produto(
    preco: 20.0,
    titulo: 'Shawarma Misto',
    descricao: 'carne de frango e bovina,alface, picles, molho de alho, batata frita e pão sirio',
    codebar: '11111113',
    categoriaId: '0',
    foto:
    'http://www.hojetemfrango.com.br/wp-content/uploads/2019/02/shutterstock_475603981.jpg',
    adicionais: sanduichesAdicional,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),Produto(
    preco: 16.0,
    titulo: 'Batata Frita',
    descricao: 'Porção de batata com molho',
    codebar: '11111113',
    categoriaId: '0',
    foto:
    'https://www.botecogois.com.br/wp-content/uploads/2021/01/batata-frita-porcao.jpg',
    adicionais: sanduichesAdicional,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),Produto(
    preco: 25.0,
    titulo: 'Batata com cheadder e bacon',
    descricao: 'porção,',
    codebar: '11111113',
    categoriaId: '0',
    foto:
    'https://www.sabornamesa.com.br/media/k2/items/cache/94ea69ba6d138bccade59f45aa6f86ca_XL.jpg',
    adicionais: sanduichesAdicional,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ), Produto(
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
    'https://gordaolanches.zapzapdelivery.com.br/wp-content/uploads/2021/05/abacaxi-hortela.jpg',
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
    'https://www.picanhacia.com.br/wp-content/uploads/2017/02/download-5.jpg',
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
    'https://www.cocacolabrasil.com.br/content/dam/journey/br/pt/brand-landing/kuat-2021/Kuat%20Lata%20350ml%206%201500px.png',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];
