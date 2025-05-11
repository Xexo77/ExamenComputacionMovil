import 'dart:convert';
import 'package:http/http.dart' as http;

class ProveedorServicio {
  final String _baseUrl = "143.198.118.203:8100";
  final String _usuario = "test";
  final String _clave = "test2023";

  Map<String, String> get _headers => {
    "Authorization": "Basic ${base64Encode(utf8.encode("$_usuario:$_clave"))}",
    "Content-Type": "application/json",
  };

Future<List<dynamic>> listarProveedores() async {
  final uri = Uri.http(_baseUrl, '/ejemplos/provider_list_rest/');
  final respuesta = await http.get(uri, headers: _headers);

  if (respuesta.statusCode == 200) {
    final decoded = jsonDecode(respuesta.body);
    if (decoded is Map<String, dynamic> && decoded.containsKey("Proveedores Listado")) {
      return decoded["Proveedores Listado"];
    } else if (decoded is List) {
      return decoded;
    } else {
      throw Exception("La API no devolvió una lista válida de proveedores.");
    }
  } else {
    throw Exception("Error al cargar proveedores: ${respuesta.statusCode}");
  }
}

  Future<bool> agregarProveedor(String nombre, String apellido, String correo, String estado) async {
    final uri = Uri.http(_baseUrl, '/ejemplos/provider_add_rest/');
    final respuesta = await http.post(uri, headers: _headers, body: jsonEncode({
      "provider_name": nombre,
      "provider_last_name": apellido,
      "provider_mail": correo,
      "provider_state": estado
    }));
    return respuesta.statusCode == 200;
  }

  Future<bool> editarProveedor(int id, String nombre, String apellido, String correo, String estado) async {
    final uri = Uri.http(_baseUrl, '/ejemplos/provider_edit_rest/');
    final respuesta = await http.post(uri, headers: _headers, body: jsonEncode({
      "provider_id": id,
      "provider_name": nombre,
      "provider_last_name": apellido,
      "provider_mail": correo,
      "provider_state": estado
    }));
    return respuesta.statusCode == 200;
  }

  Future<bool> eliminarProveedor(int id) async {
    final uri = Uri.http(_baseUrl, '/ejemplos/provider_del_rest/');
    final respuesta = await http.post(uri, headers: _headers, body: jsonEncode({"provider_id": id}));
    return respuesta.statusCode == 200;
  }
}

