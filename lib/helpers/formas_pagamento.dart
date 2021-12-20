import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

List tiposFormasPagamento = [
  {
    'nome': 'dinheiro',
    'icon': Icons.attach_money,
    'texto': 'Dinheiro',
    'isSelected': false
  },
  {
    'nome': 'inApp',
    'icon': Icons.web,
    'texto': 'Pelo Aplicativo',
    'isSelected': false
  },
  {
    'nome': 'pix',
    'icon': 'assets/pix.png',
    'texto': 'Pix',
    'isSelected': false
  },
  {'nome': 'cheque', 'icon': Mdi.card, 'texto': 'Cheque', 'isSelected': false},
  {
    'nome': 'cartão',
    'icon': Mdi.creditCard,
    'texto': 'Cartão de Crédito',
    'isSelected': false
  },
  {
    'nome': 'debito',
    'icon': Mdi.creditCard,
    'texto': 'Cartão de Debito',
    'isSelected': false
  },
];
