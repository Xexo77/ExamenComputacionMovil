import 'package:flutter/material.dart';
import 'package:examen_comp_movil/servicios/proveedor_servicio.dart';
import 'package:examen_comp_movil/tema/colores_personalizados.dart';

class EliminarProveedores extends StatefulWidget {
  const EliminarProveedores({super.key});

  @override
  State<EliminarProveedores> createState() => _EliminarProveedorState();
}

class _EliminarProveedorState extends State<EliminarProveedores> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();

  final ProveedorServicio _servicio = ProveedorServicio();

  void _eliminarProveedor() async {
    if (_formKey.currentState!.validate()) {
      final id = int.tryParse(_idController.text.trim());

      if (id == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('ID inválido'),
          backgroundColor: Colors.red,
        ));
        return;
      }

      final exito = await _servicio.eliminarProveedor(id);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(exito ? 'Proveedor eliminado' : 'Error al eliminar'),
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
        title: const Text('Eliminar Proveedor', style: TextStyle(color: ColoresPersonalizados.textoverde)),
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
                decoration: const InputDecoration(labelText: 'ID del proveedor'),
                validator: (value) => value == null || value.trim().isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _eliminarProveedor,
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
