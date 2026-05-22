import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/category.dart';

class CategoryService {
  late String _baseUrl;

  CategoryService() {
    _baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000/api';
  }

  Future<List<Category>> getCategoriesByRestaurant(int restaurantId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/categorias'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        final categories = jsonData
            .map((json) => Category.fromJson(json as Map<String, dynamic>))
            .toList();

        // Cargar los items para cada categoría
        for (var category in categories) {
          category.itemsMenu.clear();
          final items = await getProductsByCategory(category.id);
          category.itemsMenu.addAll(items);
        }

        return categories;
      } else {
        throw Exception('Error al cargar categorías: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en CategoryService: $e');
    }
  }

  Future<Category?> getCategoryById(int categoryId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/categorias/$categoryId'),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final category = Category.fromJson(json);

        final items = await getProductsByCategory(categoryId);
        category.itemsMenu.addAll(items);

        return category;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error al obtener categoría: $e');
    }
  }

  Future<List<ItemMenu>> getProductsByCategory(int categoryId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/productos/categoria/$categoryId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData
            .map((json) => ItemMenu.fromJson(json as Map<String, dynamic>))
            .toList();
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception('Error al cargar productos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en getProductsByCategory: $e');
    }
  }

  Future<List<ItemMenu>> getAllProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/productos'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData
            .map((json) => ItemMenu.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Error al cargar productos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en getAllProducts: $e');
    }
  }

  Future<ItemMenu?> getProductById(int productId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/productos/$productId'),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return ItemMenu.fromJson(json);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error al obtener producto: $e');
    }
  }
}
