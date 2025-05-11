import 'package:examen_comp_movil/pantallas/categorias/agregar_categorias.dart';
import 'package:examen_comp_movil/pantallas/categorias/editar_categorias.dart';
import 'package:examen_comp_movil/pantallas/categorias/listar_categorias.dart';
import 'package:examen_comp_movil/pantallas/categorias/modulo_categorias.dart';
import 'package:examen_comp_movil/pantallas/productos/agregar_productos.dart';
import 'package:examen_comp_movil/pantallas/productos/editar_productos.dart';
import 'package:examen_comp_movil/pantallas/productos/eliminar_productos.dart';
import 'package:examen_comp_movil/pantallas/proveedores/agregar_proveedores.dart';
import 'package:examen_comp_movil/pantallas/proveedores/editar_proveedores.dart';
import 'package:examen_comp_movil/pantallas/proveedores/eliminar_proveedores.dart';
import 'package:examen_comp_movil/pantallas/proveedores/listar_proveedores.dart';
import 'package:examen_comp_movil/pantallas/proveedores/modulo_proveedores.dart';
import 'package:examen_comp_movil/pantallas/inicio_de_sesion.dart';
import 'package:examen_comp_movil/pantallas/pantalla_principal.dart';
import 'package:examen_comp_movil/pantallas/productos/listar_productos.dart';
import 'package:examen_comp_movil/pantallas/productos/modulo_productos.dart';
import 'package:examen_comp_movil/pantallas/registrar_usuario.dart';
import 'package:examen_comp_movil/tema/colores_personalizados.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Gestión',
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        scaffoldBackgroundColor: ColoresPersonalizados.fondogris,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: ColoresPersonalizados.textoverde),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const InicioDeSesion(),

        '/pantallaPrincipal': (context) => const PantallaPrincipal(),
        '/registrarUsuario': (context) => const RegistrarUsuario(),

        '/moduloProductos': (context) => const ModuloProductos(),
        '/listarProductos': (context) => const ListarProductos(),
        '/agregarProductos': (context) => const AgregarProductos(),
        '/editarProductos': (context) => const EditarProductos(),
        '/eliminarProductos': (context) => const EliminarProductos(),

        '/moduloCategorias': (context) => const ModuloCategorias(),
        '/listarCategorias': (context) => const ListarCategorias(),
        '/agregarCategorias': (context) => const AgregarCategorias(),
        '/editarCategorias': (context) => const EditarCategorias(),
        '/eliminarCategorias': (context) => const EliminarProductos(),

        '/moduloProveedores': (context) => const ModuloProveedores(),
        '/listarProveedores': (context) => const ListarProveedores(),
        '/agregarProveedores': (context) => const AgregarProveedores(),
        '/editarProveedores': (context) => const EditarProveedores(),
        '/eliminarProveedores': (context) => const EliminarProveedores(),
      },
    );
  }
}
