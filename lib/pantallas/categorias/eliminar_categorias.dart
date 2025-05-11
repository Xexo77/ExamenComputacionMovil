import 'package:flutter/material.dart';
import 'package:examen_comp_movil/servicios/categoria_servicio.dart';
import 'package:examen_comp_movil/tema/colores_personalizados.dart';

class EliminarCategorias extends StatefulWidget {
  const EliminarCategorias({super.key});

  @override
  State<EliminarCategorias> createState() => _EliminarCategoriaState();
}

class _EliminarCategoriaState extends State<EliminarCategorias> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final CategoriaServicio _servicio = CategoriaServicio();

  void _eliminarCategoria() async {
    if (_formKey.currentState!.validate()) {
      final id = int.tryParse(_idController.text.trim());

      if (id == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('ID inválido'),
          backgroundColor: Colors.red,
        ));
        return;
      }

      final exito = await _servicio.eliminarCategoria(id);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(exito ? 'Categoría eliminada' : 'Error al eliminar'),
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
        title: const Text('Eliminar Categoría', style: TextStyle(color: ColoresPersonalizados.textoverde)),
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
                controller: _idController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'ID de la categoría'),
                validator: (value) => value == null || value.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _eliminarCategoria,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColoresPersonalizados.botonnaranja,
                  foregroundColor: ColoresPersonalizados.bordenegro,
                ),
                child: const Text('Eliminar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
