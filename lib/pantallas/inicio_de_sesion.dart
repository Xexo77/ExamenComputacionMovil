import 'package:examen_comp_movil/servicios/autenticar_servicio.dart';
import 'package:flutter/material.dart'; 

class InicioDeSesion extends StatefulWidget {
  const InicioDeSesion({super.key});

  @override
  State<InicioDeSesion> createState() => _InicioDeSesionState();
}

class _InicioDeSesionState extends State<InicioDeSesion> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  void _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    final authService = AutenticarServicio();
    final token = await authService.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() => _loading = false);

    if (token != null) {
      Navigator.pushReplacementNamed(context, '/pantallaPrincipal');
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Credenciales inválidas')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar Sesión')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                  ),
                  validator:
                      (value) =>
                          value != null && value.contains('@')
                              ? null
                              : 'Correo inválido',
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                  validator:
                      (value) =>
                          value != null && value.length >= 5
                              ? null
                              : 'Contraseña inválida',
                ),
                const SizedBox(height: 20),
                _loading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                      onPressed: _login,
                      child: const Text('Ingresar'),
                    ),
                TextButton(
                  onPressed:
                      () => Navigator.pushNamed(context, '/registrarUsuario'),
                  child: const Text('Crear cuenta nueva'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
