import 'package:flutter/material.dart';
import 'package:examen_comp_movil/servicios/categoria_servicio.dart';
import 'package:examen_comp_movil/tema/colores_personalizados.dart';

class ListarCategorias extends StatefulWidget {
  const ListarCategorias({super.key});

  @override
  State<ListarCategorias> createState() => _ListarCategoriasState();
}

class _ListarCategoriasState extends State<ListarCategorias> {
  final CategoriaServicio _categoriaServicio = CategoriaServicio();
  late Future<List<dynamic>> _categoriasFuturo;

  @override
  void initState() {
    super.initState();
    _categoriasFuturo = _categoriaServicio.listarCategorias(); 
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
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: ColoresPersonalizados.textoverde),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/pantallaPrincipal', (_) => false),
          ),
        ],
        title: const Text(
          "Listar Categorías",
          style: TextStyle(color: ColoresPersonalizados.textoverde),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _categoriasFuturo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: ColoresPersonalizados.textoverde),
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
                'No hay categorías disponibles',
                style: TextStyle(color: ColoresPersonalizados.textoverde),
              ),
            );
          }

          final categorias = snapshot.data!;
          return ListView.builder(
            itemCount: categorias.length,
            itemBuilder: (context, index) {
              final categoria = categorias[index];
              return Card(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: ColoresPersonalizados.botonnaranja),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  title: Text(
                     '${categoria['category_name'] ?? 'Sin nombre'} (ID: ${categoria['category_id'] ?? '---'})',
                    style: const TextStyle(color: ColoresPersonalizados.textoverde),
                  ),
                  subtitle: Text(
                    'Estado: ${categoria['category_state'] ?? 'Desconocido'}',
                    style: const TextStyle(color: ColoresPersonalizados.textoverde),
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

