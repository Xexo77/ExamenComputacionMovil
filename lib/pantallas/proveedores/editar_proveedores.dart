import 'package:flutter/material.dart';
import 'package:examen_comp_movil/servicios/proveedor_servicio.dart';
import 'package:examen_comp_movil/tema/colores_personalizados.dart';

class EditarProveedores extends StatefulWidget {
  const EditarProveedores({super.key});

  @override
  State<EditarProveedores> createState() => _EditarProveedorState();
}

class _EditarProveedorState extends State<EditarProveedores> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _correoController = TextEditingController();
  String _estado = 'Activo';

  final ProveedorServicio _servicio = ProveedorServicio();

  void _editarProveedor() async {
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
      final apellido = _apellidoController.text.trim();
      final correo = _correoController.text.trim();

      final exito = await _servicio.editarProveedor(id, nombre, apellido, correo, _estado);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(exito ? 'Proveedor actualizado' : 'Error al actualizar'),
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
        title: const Text('Editar Proveedor', style: TextStyle(color: ColoresPersonalizados.textoverde)),
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
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'ID del proveedor'),
                validator: (value) => value == null || value.trim().isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) => value == null || value.trim().isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _apellidoController,
                decoration: const InputDecoration(labelText: 'Apellido'),
                validator: (value) => value == null || value.trim().isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _correoController,
                decoration: const InputDecoration(labelText: 'Correo electrónico'),
                validator: (value) =>
                    value == null || value.trim().isEmpty || !value.contains('@') ? 'Correo inválido' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _estado,
                items: ['Activo', 'Inactivo']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _estado = value);
                },
                decoration: const InputDecoration(labelText: 'Estado'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _editarProveedor,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColoresPersonalizados.botonnaranja,
                  foregroundColor: ColoresPersonalizados.bordenegro,
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
