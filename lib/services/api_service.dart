import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/restaurant_item.dart';

class ApiService {
  static const String baseUrl =
      'https://fakerestaurantapi.runasp.net/api/Restaurant';

  static Future<List<RestaurantItem>> getRestaurantItems() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/items'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((item) => RestaurantItem.fromJson(item)).toList();
      } else {
        throw Exception(
          'Failed to load restaurant items: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to load restaurant items: $e');
    }
  }

  static Future<List<RestaurantItem>> searchItems(String itemName) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/items?ItemName=$itemName'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((item) => RestaurantItem.fromJson(item)).toList();
      } else {
        throw Exception('Failed to search items: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to search items: $e');
    }
  }

  static Future<List<RestaurantItem>> getSortedItems({
    String sortOrder = 'asc',
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/items?sortbyprice=$sortOrder'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((item) => RestaurantItem.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load sorted items: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load sorted items: $e');
    }
  }
}
