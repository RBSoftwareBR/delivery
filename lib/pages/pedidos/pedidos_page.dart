import 'package:delivery/controllers/pedidos_controller.dart';
import 'package:delivery/helpers/constants.dart';
import 'package:delivery/models/pedido_model.dart';
import 'package:delivery/widgets/efetuar_login_widget.dart';
import 'package:delivery/widgets/list_itens/pedido_list_item.dart';
import 'package:delivery/widgets/loading_widget.dart';
import 'package:delivery/widgets/my_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PedidosPage extends StatefulWidget {
  final String code = 'Pedidos Page';
  const PedidosPage({Key? key}) : super(key: key);

  @override
  _PedidosPageState createState() {
    return _PedidosPageState();
  }
}

class _PedidosPageState extends State<PedidosPage> {
  @override
  void initState() {
    super.initState();
    pc = PedidosController(
      localUser!,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  ScrollController sc = ScrollController();
  late PedidosController pc;
  @override
  Widget build(BuildContext context) {
    if (localUser == null) {
      return Scaffold(
          appBar: myAppBar('Pedidos', context, isImage: false,),
          body: Column(children: efetuarLoginWidget(context)));
    }
    return Scaffold(
      appBar: myAppBar(
        'Pedidos',
        context,
        isImage: false,
      ),
      body: StreamBuilder<List<Pedido>?>(
        stream: pc.outPedidos,
        builder: (context, snap) {
          if (snap.data == null) {
            return const LoadingWidget();
          }
          if (snap.data!.isEmpty) {
            return const LoadingWidget();
          }
          return SmartRefresher(
              enablePullUp: true,
              header: const WaterDropHeader(),
              footer: CustomFooter(
                builder: (BuildContext c, LoadStatus? mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = const Text("",style: TextStyle( fontFamily: 'raleway',),);
                  } else if (mode == LoadStatus.loading) {
                    body = const CupertinoActivityIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = const Text("",style: TextStyle( fontFamily: 'raleway',),);
                  } else if (mode == LoadStatus.canLoading) {
                    body = const Text("",style: TextStyle( fontFamily: 'raleway',),);
                  } else {
                    body = const Text("",style: TextStyle( fontFamily: 'raleway',),);
                  }
                  return  SizedBox(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              controller: _refreshController,
              physics: const ClampingScrollPhysics(),
              onRefresh: () {
                pc.buscar(
                  localUser!,
                ).then((v) {
                  if (v) {
                    _refreshController.refreshCompleted();
                  } else {
                    _refreshController.refreshFailed();
                  }
                });
              },
              onLoading: () {},
              //semanticChildCount: itens,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: snap.data!.length,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      PedidoListItem(
                        snap.data![i],
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 3,
                        indent: 20,
                        endIndent: 20,
                      )
                    ],
                  );
                },
              ));
        },
      ),
    );
  }


}
