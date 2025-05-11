import 'package:examen_comp_movil/tema/colores_personalizados.dart';
import 'package:flutter/material.dart';

class ModuloProductos extends StatelessWidget {
  const ModuloProductos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColoresPersonalizados.bordenegro,
        title: const Text(
          'Módulo de Productos',
          style: TextStyle(color: ColoresPersonalizados.textoverde),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColoresPersonalizados.textoverde),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: ColoresPersonalizados.textoverde),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              '/pantallaPrincipal',
              (_) => false,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _botonOperacion(context, 'Listar Productos', '/listarProductos'),
            const SizedBox(height: 16),
            _botonOperacion(context, 'Agregar Producto', '/agregarProductos'),
            const SizedBox(height: 16),
            _botonOperacion(context, 'Editar Producto', '/editarProductos'),
            const SizedBox(height: 16),
            _botonOperacion(context, 'Eliminar Producto', '/eliminarProductos'),
          ],
        ),
      ),
    );
  }

  Widget _botonOperacion(BuildContext context, String texto, String ruta) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, ruta),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColoresPersonalizados.botonnaranja,
          foregroundColor: ColoresPersonalizados.bordenegro,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(
          texto,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
