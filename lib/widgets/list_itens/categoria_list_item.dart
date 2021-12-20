import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery/controllers/produtos_controller.dart';
import 'package:delivery/helpers/styles.dart';
import 'package:delivery/models/categoria_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoriaListItem extends StatefulWidget {
  Categoria categoria;
  CategoriaListItem(this.categoria, {Key? key}) : super(key: key);

  @override
  _CategoriaListItemState createState() => _CategoriaListItemState();
}

class _CategoriaListItemState extends State<CategoriaListItem> {
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
    return StreamBuilder<String?>(
        stream: pc.outCategoriaSelecionada,
        builder: (context, categoriaSelecionada) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: () {
                if (widget.categoria.id! == categoriaSelecionada.data) {
                  pc.buscarProdutos(termo: pc.termoDeBusca, reset: true);
                } else {
                  pc.searchController.text = '';
                  pc.buscarProdutosPorCategoria(widget.categoria.id!,
                      termo: pc.searchController.text, reset: true);
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Column(
                  children: [
                    Container(
                        width: 75,
                        height: 75,
                        color: widget.categoria.id! != categoriaSelecionada.data
                            ? Colors.white
                            : corSecundaria[200],
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image(
                            image: CachedNetworkImageProvider(
                                widget.categoria.foto),
                            fit: BoxFit.fill,
                          ),
                        )),
                    Text(
                      widget.categoria.nome,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textColorgrey,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
