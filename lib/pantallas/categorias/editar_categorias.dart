import 'package:flutter/material.dart';
import 'package:examen_comp_movil/servicios/categoria_servicio.dart';
import 'package:examen_comp_movil/tema/colores_personalizados.dart';

class EditarCategorias extends StatefulWidget {
  const EditarCategorias({super.key});

  @override
  State<EditarCategorias> createState() => _EditarCategoriaState();
}

class _EditarCategoriaState extends State<EditarCategorias> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _nombreController = TextEditingController();
  String _estado = 'Activa';

  final CategoriaServicio _servicio = CategoriaServicio();

  void _guardarCambios() async {
    if (_formKey.currentState!.validate()) {
      final id = int.tryParse(_idController.text.trim());
      if (id == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('ID inválido'),
          backgroundColor: Colors.red,
        ));
        return;
      }

      final nombre = _nombreController.text.trim();
      final exito = await _servicio.editarCategoria(id, nombre, _estado);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(exito ? 'Categoría actualizada' : 'Error al actualizar'),
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
        title: const Text('Editar Categoría', style: TextStyle(color: ColoresPersonalizados.textoverde)),
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
          child: ListView(
            children: [
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(labelText: 'ID'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nuevo nombre'),
                validator: (value) => value == null || value.trim().isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _estado,
                items: ['Activa', 'Inactiva']
                    .map((estado) => DropdownMenuItem(value: estado, child: Text(estado)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _estado = value);
                },
                decoration: const InputDecoration(labelText: 'Estado'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _guardarCambios,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColoresPersonalizados.botonnaranja,
                  foregroundColor: ColoresPersonalizados.bordenegro,
                ),
                child: const Text('Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
