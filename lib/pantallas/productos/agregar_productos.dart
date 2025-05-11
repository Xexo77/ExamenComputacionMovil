import 'package:flutter/material.dart';
import 'package:examen_comp_movil/servicios/producto_servicio.dart';
import 'package:examen_comp_movil/tema/colores_personalizados.dart';

class AgregarProductos extends StatefulWidget {
  const AgregarProductos({super.key});

  @override
  State<AgregarProductos> createState() => _AgregarProductoState();
}

class _AgregarProductoState extends State<AgregarProductos> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _precioController = TextEditingController();
  final _imagenController = TextEditingController();

  final ProductoServicio _productoServicio = ProductoServicio();

  void _guardarProducto() async {
    if (_formKey.currentState!.validate()) {
      final nombre = _nombreController.text.trim();
      final precio = double.parse(_precioController.text.trim());
      final imagen = _imagenController.text.trim();

      final exito = await _productoServicio.agregarProducto(
        nombre,
        precio,
        imagen,
      );
      final mensaje =
          exito
              ? 'Producto agregado exitosamente'
              : 'Error al agregar producto';
      final color = exito ? Colors.green : Colors.red;

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(mensaje), backgroundColor: color),
        );

        if (exito) {
          Navigator.pop(context); // Vuelve atrás tras éxito
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColoresPersonalizados.bordenegro,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColoresPersonalizados.textoverde,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Agregar Productos",
          style: TextStyle(color: ColoresPersonalizados.textoverde),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: "Nombre del producto",
                ),
                validator:
                    (value) =>
                        (value == null || value.trim().isEmpty)
                            ? "Ingrese un nombre"
                            : null,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _precioController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Precio"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Ingrese un precio";
                  }
                  final parsed = double.tryParse(value);
                  if (parsed == null || parsed <= 0) return "Precio inválido";
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _imagenController,
                decoration: const InputDecoration(
                  labelText: "URL de la imagen",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Ingrese una URL";
                  }
                  if (value.length > 254) {
                    return "La URL demaciado extensa";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _guardarProducto,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColoresPersonalizados.botonnaranja,
                  foregroundColor: ColoresPersonalizados.bordenegro,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("Guardar Producto"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
