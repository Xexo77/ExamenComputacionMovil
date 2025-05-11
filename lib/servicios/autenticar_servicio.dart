import 'dart:convert';
import 'package:http/http.dart' as http;

class AutenticarServicio {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyCwQYMMlROaHlO12wGuTuIwBxTezL2iBdU';

  Future<String?> login(String email, String password) async {
    final url = Uri.https(
      _baseUrl,
      '/v1/accounts:signInWithPassword',
      {
        'key': _firebaseToken,
      },
    );

    final resp = await http.post(
      url,
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      // Autenticación exitosa
      final idToken = decodedResp['idToken'];
      print('Token: $idToken');
      return idToken;
    } else {
      // Error en la autenticación
      print('Error: ${decodedResp['error']['message']}');
      return null;
    }
  }
  Future<String?> register(String email, String password) async {
  final url = Uri.https(
    _baseUrl,
    '/v1/accounts:signUp',
    {'key': _firebaseToken},
  );

  final resp = await http.post(
    url,
    body: json.encode({
      'email': email,
      'password': password,
      'returnSecureToken': true,
    }),
  );

  final Map<String, dynamic> decodedResp = json.decode(resp.body);

  if (decodedResp.containsKey('idToken')) {
    return decodedResp['idToken'];
  } else {
    print('Error al registrar: ${decodedResp['error']['message']}');
    return null;
  }
}
}