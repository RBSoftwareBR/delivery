import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:delivery/helpers/constants.dart';
import 'package:delivery/helpers/styles.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

class HomePage extends StatefulWidget {
  final String code = 'Home Page';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final GlobalKey scaffoldKey = GlobalKey();

  int _indiceAtual = 1;
  void onTabTapped(int index) {
    setState(() {
      _indiceAtual = index;
    });
  }

  final List<Widget> _telas = [
    Container(),
    Container(),
    Container(),
  ];
  final iconList = <Widget>[
    const Icon(
      Mdi.trophyVariantOutline,
      size: 35,
      color: Colors.white,
    ),
    const Icon(
      Mdi.home,
      size: 35,
      color: Colors.white,
    ),
    const Icon(
      Mdi.accountOutline,
      color: Colors.white,
      size: 35,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _telas[_indiceAtual]),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        items: iconList,
        index: _indiceAtual,
        color: corPrimaria,
        height: 75,
        buttonBackgroundColor: corSecundaria,
        onTap: (index) => setState(() => _indiceAtual = index),
      ),
    );
  }
}
