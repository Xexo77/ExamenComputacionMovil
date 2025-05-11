import 'package:flutter/material.dart';
import 'package:examen_comp_movil/servicios/proveedor_servicio.dart';
import 'package:examen_comp_movil/tema/colores_personalizados.dart';

class ListarProveedores extends StatefulWidget {
  const ListarProveedores({super.key});

  @override
  State<ListarProveedores> createState() => _ListarProveedoresState();
}

class _ListarProveedoresState extends State<ListarProveedores> {
  final ProveedorServicio _servicio = ProveedorServicio();
  late Future<List<dynamic>> _proveedoresFuturo;

  @override
  void initState() {
    super.initState();
    _proveedoresFuturo = _servicio.listarProveedores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColoresPersonalizados.bordenegro,
        title: const Text('Lista de Proveedores', style: TextStyle(color: ColoresPersonalizados.textoverde)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColoresPersonalizados.textoverde),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: ColoresPersonalizados.textoverde),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/pantallaPrincipal', (_) => false),
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _proveedoresFuturo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: ColoresPersonalizados.textoverde));
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}', style: const TextStyle(color: ColoresPersonalizados.textoverde)),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No hay proveedores disponibles', style: TextStyle(color: ColoresPersonalizados.textoverde)),
            );
          }

          final proveedores = snapshot.data!;
          return ListView.builder(
            itemCount: proveedores.length,
            itemBuilder: (context, index) {
              final proveedor = proveedores[index];
              return Card(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: ColoresPersonalizados.botonnaranja),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  title: Text(
                    '${proveedor['provider_name']} ${proveedor['provider_last_name']} (ID: ${proveedor['providerid']})',
                    style: const TextStyle(color: ColoresPersonalizados.textoverde),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Correo: ${proveedor['provider_mail'] ?? '---'}',
                          style: const TextStyle(color: ColoresPersonalizados.textoverde)),
                      Text('Estado: ${proveedor['provider_state'] ?? '---'}',
                          style: const TextStyle(color: ColoresPersonalizados.textoverde)),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

