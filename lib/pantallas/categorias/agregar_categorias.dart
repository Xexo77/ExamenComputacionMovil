import 'package:flutter/material.dart';
import 'package:examen_comp_movil/servicios/categoria_servicio.dart';
import 'package:examen_comp_movil/tema/colores_personalizados.dart';

class AgregarCategorias extends StatefulWidget {
  const AgregarCategorias({super.key});

  @override
  State<AgregarCategorias> createState() => _AgregarCategoriaState();
}

class _AgregarCategoriaState extends State<AgregarCategorias> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final CategoriaServicio _servicio = CategoriaServicio();

  void _guardarCategoria() async {
    if (_formKey.currentState!.validate()) {
      final nombre = _nombreController.text.trim();
      final exito = await _servicio.agregarCategoria(nombre);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(exito ? 'Categoría agregada' : 'Error al agregar'),
          backgroundColor: exito ? Colors.green : Colors.red,
        ),
      );

      if (exito) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Categoría', style: TextStyle(color: ColoresPersonalizados.textoverde)),
        backgroundColor: ColoresPersonalizados.bordenegro,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColoresPersonalizados.textoverde),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre de la categoría'),
                validator: (value) => value == null || value.trim().isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _guardarCategoria,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColoresPersonalizados.botonnaranja,
                  foregroundColor: ColoresPersonalizados.bordenegro,
                ),
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
