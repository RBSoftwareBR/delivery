import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery/helpers/helper.dart';
import 'package:delivery/helpers/styles.dart';
import 'package:delivery/models/produto_model.dart';
import 'package:delivery/widgets/bottom_sheets/produto_bottom_sheet.dart';
import 'package:flutter/material.dart';
// ignore: must_be_immutable
class ProdutoListItem extends StatefulWidget {
  Produto produto;
  ProdutoListItem(this.produto,{ Key? key}) : super(key: key);

  @override
  _ProdutoListItemState createState() => _ProdutoListItemState();
}

class _ProdutoListItemState extends State<ProdutoListItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(shape: cardShape,color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:16.0,vertical: 4),
        child: InkWell(
          onTap: () {
            buildProdutoBottomSheet(context,  widget.produto);
          },
          child: Stack(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: getLargura(context) * .2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Hero(
                        tag: widget.produto.id!,
                        child: Image(
                          image: CachedNetworkImageProvider(widget.produto.foto!),
                          width: 150,
                          height: 150,
                        ),
                      ), //produto.foto
                    ),
                  ),
                  sb,
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: getLargura(context) * .65,
                          child: Text(
                            widget.produto.titulo,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            widget.produto.descricao,
                            style: TextStyle(color: textColorgrey, fontSize: 16),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Wrap(alignment: WrapAlignment.end, children: [
                            Text(
                                'R\$${widget.produto.preco.toStringAsFixed(2)}',
                                maxLines: 1,
                                style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                )
                            ),
                          ]),
                        ),
                        sb,
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
