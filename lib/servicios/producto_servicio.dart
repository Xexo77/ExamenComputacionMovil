import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductoServicio {
  final String _baseUrl = "143.198.118.203:8100";
  final String _usuario = "test";
  final String _clave = "test2023";

  Map<String, String> get _headers => {
    "Authorization": "Basic ${base64Encode(utf8.encode("$_usuario:$_clave"))}",
    "Content-Type": "application/json",
  };

  Future<List<dynamic>> listarProductos() async {
    final uri = Uri.http(_baseUrl, '/ejemplos/product_list_rest/');
    final respuesta = await http.get(uri, headers: _headers);

    if (respuesta.statusCode == 200) {
      final decoded = jsonDecode(respuesta.body);
      if (decoded is List) {
        return decoded;
      } else if (decoded is Map<String, dynamic> &&
          decoded.containsKey('Listado')) {
        return decoded['Listado'];
      } else {
        throw Exception("La API no devolvió una lista de productos.");
      }
    } else {
      throw Exception("Error al cargar productos: ${respuesta.statusCode}");
    }
  }

  Future<bool> agregarProducto(
    String nombre,
    double precio,
    String imagenUrl,
  ) async {
    final uri = Uri.http(_baseUrl, '/ejemplos/product_add_rest/');
    final respuesta = await http.post(
      uri,
      headers: _headers,
      body: jsonEncode({
        "product_name": nombre,
        "product_price": precio,
        "product_image": imagenUrl,
      }),
    );
    return respuesta.statusCode == 200;
  }

Future<bool> editarProducto(int id, String nombre, double precio, String imagen, String estado) async {
  final uri = Uri.http(_baseUrl, '/ejemplos/product_edit_rest/');
  final respuesta = await http.post(uri, headers: _headers, body: jsonEncode({
    "product_id": id,
    "product_name": nombre,
    "product_price": precio,
    "product_image": imagen,
    "product_state": estado
  }));
  return respuesta.statusCode == 200;
}

  Future<bool> eliminarProducto(int id) async {
  final uri = Uri.http(_baseUrl, '/ejemplos/product_del_rest/');
  final respuesta = await http.post(
    uri,
    headers: _headers,
    body: jsonEncode({"product_id": id}),
  );
  return respuesta.statusCode == 200;
}

}
