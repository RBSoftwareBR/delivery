import 'dart:io';
import 'package:delivery/models/pedido_model.dart';
import 'package:delivery/models/produto_carrinho_model.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import 'constants.dart';
import 'formas_pagamento.dart';
import 'helper.dart';

double larguraComMargem = 481.8897637795277;
double alturaComMargem = 1077.165354330709;
double margem = 56.69291338582677;
SizedBox sbp = SizedBox(height: 10, width: 10);
List<Widget> respostas = [];

const tableHeaders = [
  'Cod',
  'Descrição',
  'Preço Unitario',
  'Quantidade',
  'Preço R\$',
  'Adicionais',
];

const baseColor =  PdfColor.fromInt(0xffEA653C);
Future<File> gerarPdfPedido(
  Pedido pedido,
) async {
  final doc = Document();

  respostas = [];
  ByteData bytes = await rootBundle.load('assets/logo.png');
  respostas.add(Container(
    color: baseColor,
    child: Padding(
        padding: const  EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 2),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(MemoryImage(bytes.buffer.asUint8List()),
                        height: alturaComMargem * .13,
                        width: larguraComMargem * .5),
                  ]),
              Container(
                  width: larguraComMargem * .3,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Delivery',
                            style: TextStyle(
                                fontSize: 9,
                                color: PdfColors.white,
                                fontWeight: FontWeight.bold)),
                        Text('CNPJ::000.000.000-00',
                            style: TextStyle(
                                fontSize: 9,
                                color: PdfColors.white,
                                fontWeight: FontWeight.bold)),
                        Text('Telefone:42999319375',
                            style: TextStyle(
                                fontSize: 9,
                                color: PdfColors.white,
                                fontWeight: FontWeight.bold)),
                        Text(
                          'Endereço:Pedro Canha Salgado, Canta Galo, Castro-PR',
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 9,
                            color: PdfColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]))
            ])),
  ));

  sbb();
  addW(
    Container(
        width: larguraComMargem,
        child: (Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Cliente: ${localUser!.nome ?? 'Teste Nome'}',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              Text('Telefone: ${localUser!.telefone}',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              Text('Email: ${localUser!.email}',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              Text(
                  'Endereço: ___________________________',
                  softWrap: true,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))
            ]))),
  );
  String formaPagamento = '';
  for (var v in tiposFormasPagamento) {
    if (v['nome'] == pedido.formaPagamento) {
      formaPagamento = v['texto'];
    }
  }

  sbb();
  addW(Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        pedido.obs == null
            ? Container()
            : Text('Observação:${pedido.obs}', style: const TextStyle(fontSize: 14)),
       Text('Forma de Pagamento: ${formaPagamento== 'inApp' ? 'Cartão de Credito' : pedido.formaPagamento.toUpperCase()}',
                style: const  TextStyle(
                  fontSize: 14,
                )),
      ]));
  sbb();

  final table = Table.fromTextArray(
    tableWidth: TableWidth.max,
    border: TableBorder.all(color: PdfColors.black),
    headers: tableHeaders,
    headerAlignment: Alignment.center,
    columnWidths: {
      0: const FlexColumnWidth(0.3),
      1: const FlexColumnWidth(0.4),
      2: const FlexColumnWidth(0.5),
      3: const FlexColumnWidth(0.5),
      4: const FlexColumnWidth(0.5),
      5: const FlexColumnWidth(0.5),
      6: const FlexColumnWidth(0.5),
    },
    data: generateDataTable(pedido.produtos),
    headerStyle: TextStyle(
        color: PdfColors.white, fontWeight: FontWeight.bold, fontSize: 9),
    headerDecoration: const BoxDecoration(
      color: baseColor,
    ),
    cellStyle: const TextStyle(color: PdfColors.black, fontSize: 7),
    rowDecoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: baseColor,
          width: .5,
        ),
      ),
    ),
  );
  sbb();
  respostas.add(
    table,
  );
  double total = 0;
  for (ProdutoCarrinho pp in pedido.produtos) {
    total += pp.totalProduto();
  }
  sbb();

  List<Widget> itens = [];

  itens.add(
    Text('Total em produtos: R\$${total.toStringAsFixed(2)}',
        style: const TextStyle(fontSize: 15)),
  );
  addW(Container(
      alignment: Alignment.bottomRight,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: itens)));
  sbb();

  doc.addPage(
    MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: EdgeInsets.all(margem),
      build: (Context context) => respostas,
    ),
  );

  final Directory appDocDir = await getApplicationDocumentsDirectory();
  final String appDocPath = appDocDir.path;
  Directory dir = Directory(appDocPath + '/Pedidos');
  dir.create();
  final File file = File(appDocPath +
      '/Pedidos/' +
      'Pedido${formatarDiaHora(DateTime.now()).replaceAll(' ', '_').replaceAll("/", "-")}.pdf');
  file.writeAsBytesSync(await doc.save());
  return file;
}

List<List> generateDataTable(List<ProdutoCarrinho> produtos) {
  List<List> dataTable = [];
  for (ProdutoCarrinho pp in produtos) {
    String adicionais = '';
    if (pp.produto.adicionais != null) {
      for (var i in pp.produto.adicionais!) {
        for (var o in i.opcoes) {
          if (o.isSelected) {
            adicionais+=o.nome+'  ';
          }
        }
      }
    }
    dataTable.add([
      pp.produto.codebar,
      pp.produto.titulo,
      pp.quantidade,
      pp.totalUnitario().toStringAsFixed(2),
      pp.totalProduto().toStringAsFixed(2),
      adicionais,
    ]);
  }
  return dataTable;
}

sbb() {
  respostas.add(sbp);
}

addW(wid) {
  respostas
      .add(Padding(padding: const EdgeInsets.symmetric(horizontal: 0), child: wid));
}
