import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/category.dart';
import '../auth/services/auth_service.dart';

class CategoryService {
  late String _baseUrl;

  CategoryService() {
    _baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:4000/api';
  }

  Future<Map<String, String>> _getHeaders() async {
    final token = await AuthService.getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<List<Category>> getCategoriesByRestaurant(int restaurantId) async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$_baseUrl/categorias'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        final categories = jsonData
            .map((json) => Category.fromJson(json as Map<String, dynamic>))
            .toList();

        for (var category in categories) {
          category.itemsMenu.clear();
          final items = await getProductsByCategory(category.id);
          category.itemsMenu.addAll(items);
        }

        return categories;
      } else if (response.statusCode == 401) {
        throw Exception('No autorizado. Por favor, inicia sesión nuevamente.');
      } else {
        throw Exception('Error al cargar categorías: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en CategoryService: $e');
    }
  }

  Future<Category?> getCategoryById(int categoryId) async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$_baseUrl/categorias/$categoryId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final category = Category.fromJson(json);

        final items = await getProductsByCategory(categoryId);
        category.itemsMenu.addAll(items);

        return category;
      } else if (response.statusCode == 401) {
        throw Exception('No autorizado.');
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error al obtener categoría: $e');
    }
  }

  Future<List<ItemMenu>> getProductsByCategory(int categoryId) async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$_baseUrl/productos/categoria/$categoryId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData
            .map((json) => ItemMenu.fromJson(json as Map<String, dynamic>))
            .toList();
      } else if (response.statusCode == 404) {
        return [];
      } else if (response.statusCode == 401) {
        throw Exception('No autorizado.');
      } else {
        throw Exception('Error al cargar productos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en getProductsByCategory: $e');
    }
  }

  Future<List<ItemMenu>> getAllProducts() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$_baseUrl/productos'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData
            .map((json) => ItemMenu.fromJson(json as Map<String, dynamic>))
            .toList();
      } else if (response.statusCode == 401) {
        throw Exception('No autorizado.');
      } else {
        throw Exception('Error al cargar productos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en getAllProducts: $e');
    }
  }

  Future<ItemMenu?> getProductById(int productId) async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$_baseUrl/productos/$productId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return ItemMenu.fromJson(json);
      } else if (response.statusCode == 401) {
        throw Exception('No autorizado.');
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error al obtener producto: $e');
    }
  }
}
