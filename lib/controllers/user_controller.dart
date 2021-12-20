import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:delivery/helpers/constants.dart';
import 'package:delivery/helpers/helper.dart';
import 'package:delivery/helpers/references.dart';
import 'package:delivery/helpers/toast.dart';
import 'package:delivery/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';

class UserController extends BlocBase {
  final code = 'User Controller';
  BehaviorSubject<Usuario?> usuarioController =
  BehaviorSubject<Usuario?>();
  Stream<Usuario?> get outUsuario => usuarioController.stream;
  Sink<Usuario?> get inUsuario => usuarioController.sink;

  Future<Usuario?> efetuarLogin(email, senha) {
    if (isEmailValid(email)) {
      return auth
          .signInWithEmailAndPassword(email: email, password: senha)
          .then((value) {
        return usuariosRef.doc(value.user!.uid).get().then((v) {
          if (v.data() != null) {
            localUser = Usuario.fromMap(v.data());
            inUsuario.add(localUser);
            return localUser;
          } else {
            toastErroLogin("Usuario Não encontrado");
            return null;
          }
        }).catchError((err) {
          onError(err.toString(), code);
          toastErroLogin('Erro ao efetuar login 1: ${err.toString()}');
          return null;
        });
      }).catchError((err) {
        onError(err.toString(), code);
        toastErroLogin('Erro ao efetuar login 2 : ${err.toString()}');
        return null;
      });
    } else {
      toastErroLogin('Email invalido');
      return Future.value(null);
    }
  }

  toastErroLogin(err) {
    if (err.toString().contains(
        'There is no user record corresponding to this identifier. The user may have been deleted')) {
      dToastBranca("Ops! Usuário não encontrado");
    } else if (err.toString().contains('address is already in use')) {
      dToastBranca("Ops! E-mail ja está em uso");
    } else if (err ==
        'The password is invalid or the user does not have a password') {
      dToastBranca(
          "Ops! talvez você tenha entrado de outra forma com esse e-mail?");
    } else if (err
        .toString()
        .contains('Null check operator used on a null value')) {
      onError(err, code);
    } else {
      dToastBranca(err.toString());
    }
  }

  @override
  void dispose() {
    usuarioController.close();
    super.dispose();
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  Future<Usuario?> efetuarLoginGoogle() async {
    try {
      GoogleSignInAccount? user = await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await user!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      return auth.signInWithCredential(credential).then((u) {
        return getOrSetUser(u);
      }).catchError((err) {
        onError(err, code);
        return null;
      });
    } catch (err) {
      onError(err, code);
      return Future.value(null);
    }
  }

  Future<Usuario?> cadastrarUsuario(
    String nome,
    String email,
    String telefone,
    String senha,
    bool hasAcceptedNotificacoes,
    bool hasAcceptedTermos,
  ) {
    return auth
        .createUserWithEmailAndPassword(
      email: email,
      password: senha,
    )
        .then((v) {
      v.user!.sendEmailVerification();
      Usuario usuario = Usuario(
        id: v.user!.uid,
        updatedAt: DateTime.now(),
        email: email,
        nome: nome,
        permissao: 0,
        notificacoes: hasAcceptedNotificacoes,
        createdAt: DateTime.now(),
        telefone: telefone,
      );
      usuario.foto = v.user!.photoURL;
      return getOrSetUser(v, user: usuario);
    }).catchError((err) {
      onError(err, code);
      toastErroLogin('Erro ao criar usuario: ${err.toString()}');
      return null;
    });
  }

  bool logout() {
    auth.signOut();
    localUser = null;
    inUsuario.add(localUser);
    return true;
  }

  Future<Usuario?> updateUser(Usuario u) async {
    await usuariosRef.doc(u.id).set(u.toMap());
    localUser = u;
    inUsuario.add(localUser);
    return localUser;
  }

  Future<Usuario?> getOrSetUser(UserCredential u, {Usuario? user}) {
    return usuariosRef.doc(u.user!.uid).get().then((v) async {
      if (v.data() != null) {
        localUser = Usuario.fromMap(v.data());
        return localUser;
      } else {
        Usuario usuario;
        if (user != null) {
          usuario = user;
        } else {
          usuario = Usuario(
              nome: u.user!.displayName,
              id: u.user!.uid,
              email: u.user!.email,
              notificacoes: false,
              permissao: 0,
              updatedAt: DateTime.now(),
              createdAt: DateTime.now(),
              telefone: u.user!.phoneNumber,
              foto: u.user!.photoURL);
        }
        usuariosRef.doc(usuario.id).set(usuario.toMap());
        localUser = usuario;
        inUsuario.add(localUser);
        return localUser;
      }
    });
  }
}
