import 'package:flutter/material.dart';
import 'package:examen_comp_movil/servicios/producto_servicio.dart';
import 'package:examen_comp_movil/tema/colores_personalizados.dart';

class EditarProductos extends StatefulWidget {
  const EditarProductos({super.key});

  @override
  State<EditarProductos> createState() => _EditarProductoState();
}

class _EditarProductoState extends State<EditarProductos> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _nombreController = TextEditingController();
  final _precioController = TextEditingController();
  final _imagenController = TextEditingController();
  String _estado = 'Activo';

  final ProductoServicio _productoServicio = ProductoServicio();

  void _editarProducto() async {
    if (_formKey.currentState!.validate()) {
      final id = int.tryParse(_idController.text.trim());
      final nombre = _nombreController.text.trim();
      final precio = double.tryParse(_precioController.text.trim()) ?? 0;
      final imagen = _imagenController.text.trim();

      if (id == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('ID inválido'),
          backgroundColor: Colors.red,
        ));
        return;
      }

      final exito = await _productoServicio.editarProducto(id, nombre, precio, imagen, _estado);

      final mensaje = exito ? 'Producto editado correctamente' : 'Error al editar';
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
        title: const Text('Editar Producto', style: TextStyle(color: ColoresPersonalizados.textoverde)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _idController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'ID del producto'),
                validator: (value) => value == null || value.isEmpty ? 'Ingrese ID' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre del producto'),
                validator: (value) => value == null || value.isEmpty ? 'Ingrese nombre' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _precioController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Precio'),
                validator: (value) {
                  final parsed = double.tryParse(value ?? '');
                  return parsed == null || parsed <= 0 ? 'Ingrese precio válido' : null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _imagenController,
                decoration: const InputDecoration(labelText: 'URL de imagen'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _estado,
                items: ['Activo', 'Inactivo']
                    .map((estado) => DropdownMenuItem(value: estado, child: Text(estado)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _estado = value);
                },
                decoration: const InputDecoration(labelText: 'Estado'),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _editarProducto,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColoresPersonalizados.botonnaranja,
                  foregroundColor: ColoresPersonalizados.bordenegro,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Guardar Cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
