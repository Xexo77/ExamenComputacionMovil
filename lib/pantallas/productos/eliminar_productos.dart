import 'package:flutter/material.dart';
import 'package:examen_comp_movil/servicios/producto_servicio.dart';
import 'package:examen_comp_movil/tema/colores_personalizados.dart';

class EliminarProductos extends StatefulWidget {
  const EliminarProductos({super.key});

  @override
  State<EliminarProductos> createState() => _EliminarProductoState();
}

class _EliminarProductoState extends State<EliminarProductos> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();

  final ProductoServicio _productoServicio = ProductoServicio();

  void _eliminarProducto() async {
    if (_formKey.currentState!.validate()) {
      final id = int.tryParse(_idController.text.trim());

      if (id == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('ID inválido'),
          backgroundColor: Colors.red,
        ));
        return;
      }

      final exito = await _productoServicio.eliminarProducto(id);

      final mensaje = exito
          ? 'Producto eliminado correctamente'
          : 'No se pudo eliminar el producto';
      final color = exito ? Colors.green : Colors.red;

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(mensaje), backgroundColor: color),
        );

        if (exito) Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColoresPersonalizados.bordenegro,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColoresPersonalizados.textoverde),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Eliminar Producto',
          style: TextStyle(color: ColoresPersonalizados.textoverde),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _idController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'ID del producto'),
                validator: (value) => value == null || value.isEmpty ? 'Ingrese un ID válido' : null,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _eliminarProducto,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColoresPersonalizados.botonnaranja,
                  foregroundColor: ColoresPersonalizados.bordenegro,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Eliminar Producto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
