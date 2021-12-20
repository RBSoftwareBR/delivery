import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery/controllers/carrinho_controller.dart';
import 'package:delivery/controllers/categorias_controller.dart';
import 'package:delivery/controllers/produtos_controller.dart';
import 'package:delivery/controllers/search_bar_animator_controller.dart';
import 'package:delivery/helpers/helper.dart';
import 'package:delivery/helpers/styles.dart';
import 'package:delivery/helpers/toast.dart';
import 'package:delivery/models/categoria_model.dart';
import 'package:delivery/models/produto_carrinho_model.dart';
import 'package:delivery/models/produto_model.dart';
import 'package:delivery/widgets/input_field.dart';
import 'package:delivery/widgets/list_itens/categoria_list_item.dart';
import 'package:delivery/widgets/list_itens/produto_list_item.dart';
import 'package:delivery/widgets/loading_widget.dart';
import 'package:delivery/widgets/microphone_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mdi/mdi.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'carrinho_page.dart';

class ProdutosPage extends StatefulWidget {
  final String code = 'Produtos Page';
  const ProdutosPage({Key? key}) : super(key: key);

  @override
  _ProdutosPageState createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {
  late CategoriasController cc;

  late SearchBarAnimatorController sbac;
  @override
  void initState() {
    super.initState();
    pc = ProdutosController();
    pc.buscarProdutos();
    cc = CategoriasController();
    cc.buscarCategorias();
    sbac = SearchBarAnimatorController(200);
    carrinhoController = CarrinhoController();
  }

  @override
  void dispose() {
    super.dispose();
  }


  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  double categoriasAltura = 150;

  final GlobalKey scaffoldKey = GlobalKey();
  void _onRefresh() {
    pc.buscarProdutos(termo: pc.searchController.text, reset: true).then((v) {
      if (v) {
        _refreshController.refreshCompleted();
      } else {
        _refreshController.refreshFailed();
      }
    });
  }

  void _onLoading() {
    pc.buscarProdutos().then((v) {
      if (v) {
        _refreshController.loadComplete();
      } else {
        _refreshController.loadNoData();
      }
    });
  }
  bool done = false;

  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      key: scaffoldKey,floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton:StreamBuilder<List<ProdutoCarrinho>>(
        stream: carrinhoController.outCarrinho,
        builder: (context, snapshot) {
          return FloatingActionButton(elevation: 0,
              backgroundColor: corPrimaria,
              onPressed: () {
                if (snapshot.data!.isNotEmpty) {
                  abrir(context, const CarrinhoPage());
                } else {
                  dToast('Nenhum produto no carrinho =/');
                }
              },
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      snapshot.data == null
                          ? ''
                          : carrinhoController.quantidadeProdutos.toString(),
                      style: const TextStyle(
                          shadows: [],
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                    const  Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  ]));
        }
      ),
      body: Builder(
          builder: (ctx) => SmartRefresher(
              enablePullUp: true,
              scrollController: controller,
              header: const WaterDropHeader(),
              footer: CustomFooter(
                builder: (BuildContext c, LoadStatus? mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = const Text("",);
                  } else if (mode == LoadStatus.loading) {
                    body = const CupertinoActivityIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = const Text("",);
                  } else if (mode == LoadStatus.canLoading) {
                    body = const Text("",);
                  } else {
                    body = const Text("Fim dos Produtos",);
                  }
                  return SizedBox(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              controller: _refreshController,
              physics: const ClampingScrollPhysics(),
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              //semanticChildCount: itens,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                dragStartBehavior: DragStartBehavior.start,
                controller: controller,
                shrinkWrap: true,
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: corPrimaria,
                    floating: true,
                    snap: true,
                    pinned: true,
                    collapsedHeight: 60,
                    toolbarHeight: 60,
                    expandedHeight: 116 + categoriasAltura,
                    elevation: 5,
                    centerTitle: true,
                    titleSpacing: 10,
                    leadingWidth: 50,
                    primary: true,
                    flexibleSpace: LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      sbac.top = constraints.biggest.height;
                      sbac.inTop.add(sbac.top);
                      return StreamBuilder<Object>(
                        stream: sbac.outTop,
                        builder: (context, topSnap) {
                          return FlexibleSpaceBar(
                            collapseMode: CollapseMode.pin,
                            title: AnimatedOpacity(
                                duration: const Duration(milliseconds: 300),
                                opacity: topSnap.data == 60.0 ? 1.0 : 0.0,
                                child: const Text(
                                  'Delivery',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontFamily: 'helvetica',
                                  ),
                                )),
                            centerTitle: true,
                            background: Container(
                              color: Colors.white,
                              child: Stack(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqs5DFMXFOV1jxJHz8D42DsSULIpaPzoVDeQ&usqp=CAU',//TODO COLOCAR FOTO AQUI,
                                    width: getLargura(context),
                                    height: getAltura(context) * .3,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      );
                    }),
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate.fixed([
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 4.0, right: 4, top: 16, bottom: 6),
                          child: TypeAheadField(
                            noItemsFoundBuilder: (context) {
                              return const SizedBox(
                                width: 0,
                                height: 0,
                              );
                            },
                            onSuggestionSelected: (String suggestion) {
                              pc.searchController.text = suggestion;
                              pc.buscarProdutos(termo: suggestion);
                            },
                            suggestionsCallback: (String pattern) {
                              //return cacheController.getUltimasBuscas(pattern);
                              return <String>[];
                            },
                            itemBuilder: (context, String suggestion) {
                              return ListTile(
                                title: Text(suggestion,),
                              );
                            },
                            textFieldConfiguration: TextFieldConfiguration(
                                controller: pc.searchController,
                                autofocus: false,style: const TextStyle(color:Colors.black),
                                //focusNode: focus,
                                textInputAction: TextInputAction.search,
                                onSubmitted: (s) {
                                  pc.buscarProdutos(termo: s);
                                },
                                decoration: defaultInputDecoration(
                                  context,
                                  hintText: 'Procure por produtos ou marcas',
                                  hintColor: Colors.grey[600],
                                  filled: true,
                                  fillColor: Colors.white,
                                  icon: Icons.search,
                                  sufix: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        height: 22.0,
                                        width: 22.0,
                                        child: IconButton(
                                          icon: const Icon(
                                            Mdi.microphone,
                                            color: Colors.black,
                                          ),
                                          padding: const EdgeInsets.all(0),
                                          splashRadius: 22,
                                          tooltip: 'Busca por voz',
                                          onPressed: () async {
                                            var status = await Permission.microphone.status;
                                            if (!status.isGranted) {
                                              await [Permission.microphone].request();
                                            }
                                            status = await Permission.microphone.status;
                                            if(status.isGranted) {
                                              var result = await showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return const MicrophoneDialog();
                                                  });
                                              pc.searchController.text = result;
                                              pc.buscarProdutos(termo: result);
                                            }
                                          },
                                        ),
                                      ),
                                      sb,
                                      sb,
                                    ],
                                  ),
                                  labelText: 'Procure por produtos ou marcas',
                                  radius: 20,
                                )),
                          ),
                        ),

                        StreamBuilder<List<Categoria>?>(
                            stream: cc.outCategorias,
                            builder: (context, snapshot) {
                              if (snapshot.data == null) {
                                return Container();
                              }
                              if (snapshot.data!.isEmpty) {
                                return Container();
                              }

                              return Container(
                                color: Colors.white,
                                width: getLargura(context),
                                height: 110,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, i) {
                                      return CategoriaListItem(
                                          cc.categorias[i]);
                                    },
                                    itemCount: cc.categorias.length,
                                  ),
                                ),
                              );
                            }),
                        StreamBuilder<List<Produto>?>(
                            stream: pc.outProdutos,
                            builder: (context, snapshot) {
                              if (snapshot.data == null) {
                                return const LoadingWidget();
                              }
                              if (snapshot.data!.isEmpty) {
                                return const LoadingWidget();
                              }
                              List<Widget> itens = [];
                              for (var i in snapshot.data!) {
                                itens.add(ProdutoListItem(
                                    i));
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemBuilder: (context, i) {
                                  return itens[i]; //categorias[i], i: i);
                                },
                                itemCount: snapshot.data!.length,
                              );
                            })
                      ]))
                ],
              ))),
      //floatingActionButton: floatingCarrinho(widget.estabelecimento);
    );
  }
}
