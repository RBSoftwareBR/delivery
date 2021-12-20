import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference usuariosRef = FirebaseFirestore.instance.collection('Usuarios');
CollectionReference carrinhosRef = FirebaseFirestore.instance.collection('Carrinhos');
CollectionReference pedidosRef = FirebaseFirestore.instance.collection('Pedidos');