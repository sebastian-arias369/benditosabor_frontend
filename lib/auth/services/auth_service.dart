import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:benditosabor/auth/models/user_model.dart';

class AuthService {
  static final storage = FlutterSecureStorage();
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'auth_user';

  // Obtener URLs desde .env
  static String get _baseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'http://localhost:4000/api';
  static String get _registerEndpoint =>
      dotenv.env['API_REGISTER_ENDPOINT'] ?? '/auth/register';
  static String get _loginEndpoint =>
      dotenv.env['API_LOGIN_ENDPOINT'] ?? '/auth/login';
  static String get _verifyTokenEndpoint =>
      dotenv.env['API_VERIFY_TOKEN_ENDPOINT'] ?? '/auth/verify';

  // Registrar nuevo usuario
  static Future<UserModel> register({
    required String nombre,
    required String correo,
    required String password,
    required String telefono,
    required String direccion,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl$_registerEndpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nombre': nombre,
          'correo': correo,
          'password': password,
          'telefono': telefono,
          'direccion': direccion,
        }),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Tiempo de conexión agotado'),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return UserModel.fromJson(data['user']);
      } else if (response.statusCode == 400) {
        final error = jsonDecode(response.body);
        throw Exception(error['error'] ?? 'Error en el registro');
      } else {
        throw Exception('Error al registrar usuario');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Login de usuario
  static Future<Map<String, dynamic>> login({
    required String correo,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl$_loginEndpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'correo': correo,
          'password': password,
        }),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Tiempo de conexión agotado'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        final user = UserModel.fromJson(data['user']);

        // Guardar token y usuario
        await storage.write(key: _tokenKey, value: token);
        await storage.write(key: _userKey, value: jsonEncode(user.toJson()));

        return {
          'token': token,
          'user': user,
        };
      } else if (response.statusCode == 401) {
        final error = jsonDecode(response.body);
        throw Exception(error['error'] ?? 'Correo o contraseña incorrectos');
      } else {
        throw Exception('Error al iniciar sesión');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Obtener token guardado
  static Future<String?> getToken() async {
    return await storage.read(key: _tokenKey);
  }

  // Obtener usuario guardado
  static Future<UserModel?> getSavedUser() async {
    final userJson = await storage.read(key: _userKey);
    if (userJson != null) {
      return UserModel.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  // Verificar si hay sesión activa
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // Logout
  static Future<void> logout() async {
    await storage.delete(key: _tokenKey);
    await storage.delete(key: _userKey);
  }

  // Verificar token con el backend (GET)
  static Future<bool> verifyToken() async {
    try {
      final token = await getToken();
      if (token == null) return false;

      final response = await http.get(
        Uri.parse('$_baseUrl$_verifyTokenEndpoint'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Tiempo de conexión agotado'),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
