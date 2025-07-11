import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;

  AuthService() {
    _auth.authStateChanges().listen((user) {
      usuario = user;
      notifyListeners();
    });
  }

  Future<UserCredential> login(String email, String senha) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: senha,
    );
    usuario = cred.user;
    notifyListeners();
    return cred;
  }

  Future<UserCredential> registrar(String email, String senha) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: senha,
    );
    usuario = cred.user;
    notifyListeners();
    return cred;
  }

  Future<void> logout() async {
    await _auth.signOut();
    usuario = null;
    notifyListeners();
  }

  bool get autenticado => usuario != null;
}
