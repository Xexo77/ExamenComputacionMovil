import 'package:examen_comp_movil/tema/colores_personalizados.dart';
import 'package:flutter/material.dart';

class ModuloProveedores extends StatelessWidget {
  const ModuloProveedores({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColoresPersonalizados.bordenegro,
        title: const Text(
          'Módulo de Proveedores',
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
            _botonOperacion(context, 'Listar Proveedores', '/listarProveedores'),
            const SizedBox(height: 16),
            _botonOperacion(context, 'Agregar Proveedores', '/agregarProveedores'),
            const SizedBox(height: 16),
            _botonOperacion(context, 'Editar Proveedores', '/editarProveedores'),
            const SizedBox(height: 16),
            _botonOperacion(context, 'Eliminar Proveedores', '/eliminarProveedores'),
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
