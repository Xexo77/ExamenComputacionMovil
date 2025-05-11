import 'package:flutter/material.dart';
import 'package:examen_comp_movil/servicios/producto_servicio.dart';
import 'package:examen_comp_movil/tema/colores_personalizados.dart';

class ListarProductos extends StatefulWidget {
  const ListarProductos({super.key});

  @override
  State<ListarProductos> createState() => _ListarProductosState();
}

class _ListarProductosState extends State<ListarProductos> {
  final ProductoServicio _productoServicio = ProductoServicio();
  late Future<List<dynamic>> _productosFuturo;

  @override
  void initState() {
    super.initState();
    _productosFuturo = _productoServicio.listarProductos();
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
        actions: [
          IconButton(
            icon: const Icon(
              Icons.home,
              color: ColoresPersonalizados.textoverde,
            ),
            onPressed:
                () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/pantallaPrincipal',
                  (_) => false,
                ),
          ),
        ],
        title: const Text(
          "Listar Productos",
          style: TextStyle(color: ColoresPersonalizados.textoverde),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _productosFuturo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: ColoresPersonalizados.textoverde,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: ColoresPersonalizados.textoverde),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No hay productos disponibles',
                style: TextStyle(color: ColoresPersonalizados.textoverde),
              ),
            );
          }

          final productos = snapshot.data!;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, index) {
              final producto = productos[index];
              return Card(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: ColoresPersonalizados.botonnaranja,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading:
                      producto['product_image'] != null
                          ? Image.network(
                            producto['product_image'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                          : const Icon(
                            Icons.image_not_supported,
                            color: ColoresPersonalizados.textoverde,
                          ),
                  title: Text(
                    '${producto['product_name'] ?? 'Sin nombre'} (ID: ${producto['product_id'] ?? '---'})',
                    style: const TextStyle(
                      color: ColoresPersonalizados.textoverde,
                    ),
                  ),
                  subtitle: Text(
                    'Precio: \$${producto['product_price'] ?? '0'}',
                    style: const TextStyle(
                      color: ColoresPersonalizados.textoverde,
                    ),
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
