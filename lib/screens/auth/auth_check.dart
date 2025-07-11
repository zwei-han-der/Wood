import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    if (auth.autenticado) {
      // Aqui você pode buscar o papel do usuário (role) e redirecionar
      // Por enquanto, redireciona para uma tela placeholder
      // Buscar role do Firestore e redirecionar para admin ou cliente
      return const PlaceholderHome();
    } else {
      return Navigator.of(context).pushReplacementNamed('/login') as Widget;
    }
  }
}

class PlaceholderHome extends StatelessWidget {
  const PlaceholderHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(
        child: Text('Usuário autenticado! (implementar navegação por role)'),
      ),
    );
  }
}
