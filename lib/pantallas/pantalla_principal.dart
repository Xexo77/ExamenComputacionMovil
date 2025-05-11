import 'package:examen_comp_movil/tema/colores_personalizados.dart';
import 'package:flutter/material.dart';

class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla Principal', style: TextStyle(color: ColoresPersonalizados.textoverde)),
        backgroundColor: ColoresPersonalizados.bordenegro,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _botonModulo(
              context,
              titulo: 'Módulo Productos',
              ruta: '/moduloProductos',
            ),
            const SizedBox(height: 20),
            _botonModulo(
              context,
              titulo: 'Módulo Categorías',
              ruta: '/moduloCategorias',
            ),
            const SizedBox(height: 20),
            _botonModulo(
              context,
              titulo: 'Módulo Proveedores',
              ruta: '/moduloProveedores',
            ),
          ],
        ),
      ),
    );
  }

  Widget _botonModulo(BuildContext context, {required String titulo, required String ruta}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, ruta),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColoresPersonalizados.botonnaranja,
          foregroundColor: ColoresPersonalizados.bordenegro,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child:Text(
          titulo,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}