import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import '../../utils/validators.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _senha = '';
  String _confirmarSenha = '';
  bool _loading = false;
  String? _erro;

  Future<void> _registrar() async {
    if (!_formKey.currentState!.validate()) return;
    if (_senha != _confirmarSenha) {
      setState(() {
        _erro = 'As senhas não coincidem.';
      });
      return;
    }
    setState(() {
      _loading = true;
      _erro = null;
    });
    try {
      await Provider.of<AuthService>(
        context,
        listen: false,
      ).registrar(_email, _senha);
      // Navegação será feita pelo AuthCheck
    } catch (e) {
      setState(() {
        _erro = 'Falha no cadastro: ${e.toString()}';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.email,
                  onChanged: (v) => _email = v,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                  validator: Validators.senha,
                  onChanged: (v) => _senha = v,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Confirmar Senha',
                  ),
                  obscureText: true,
                  validator: Validators.senha,
                  onChanged: (v) => _confirmarSenha = v,
                ),
                const SizedBox(height: 16),
                if (_erro != null) ...[
                  Text(_erro!, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 8),
                ],
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _registrar,
                    child: _loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Cadastrar'),
                  ),
                ),
                TextButton(
                  onPressed: _loading
                      ? null
                      : () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                  child: const Text('Já tem conta? Entrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
