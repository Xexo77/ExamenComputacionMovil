import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoriaServicio {
  final String _baseUrl = "143.198.118.203:8100";
  final String _usuario = "test";
  final String _clave = "test2023";

  Map<String, String> get _headers => {
    "Authorization": "Basic ${base64Encode(utf8.encode("$_usuario:$_clave"))}",
    "Content-Type": "application/json",
  };

  Future<List<dynamic>> listarCategorias() async {
    final uri = Uri.http(_baseUrl, '/ejemplos/category_list_rest/');
    final respuesta = await http.get(uri, headers: _headers);

    if (respuesta.statusCode == 200) {
      final decoded = jsonDecode(respuesta.body);
      if (decoded is Map<String, dynamic> && decoded.containsKey("Listado Categorias")) {
        return decoded["Listado Categorias"]; 
      } else {
        throw Exception("La API no devolvió la clave 'Listado Categorias'.");
      }
    } else {
      throw Exception("Error al cargar categorías: ${respuesta.statusCode}");
    }
  }

  Future<bool> agregarCategoria(String nombre) async {
    final uri = Uri.http(_baseUrl, '/ejemplos/category_add_rest/');
    final respuesta = await http.post(uri, headers: _headers, body: jsonEncode({"category_name": nombre}));
    return respuesta.statusCode == 200;
  }

  Future<bool> editarCategoria(int id, String nombre, String estado) async {
    final uri = Uri.http(_baseUrl, '/ejemplos/category_edit_rest/');
    final respuesta = await http.post(
      uri,
      headers: _headers,
      body: jsonEncode({
        "category_id": id,
        "category_name": nombre,
        "category_state": estado,
      }),
    );
    return respuesta.statusCode == 200;
  }

  Future<bool> eliminarCategoria(int id) async {
    final uri = Uri.http(_baseUrl, '/ejemplos/category_del_rest/');
    final respuesta = await http.post(uri, headers: _headers, body: jsonEncode({"category_id": id}));
    return respuesta.statusCode == 200;
  }
}

