import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meal_admin_app/models/shop_info.dart';

import '../models/categories.dart';
import '../models/meal.dart';

class ProviderRepository {
  Future addCategory(String category) async {
    String url =
        'https://meal-admin-app-default-rtdb.firebaseio.com/categories.json';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          "name": category,
          "entries": '',
        }),
      );
    } catch (e) {
      throw e;
    }
  }

  Future<List<Categories>> getListCategories() async {
    String url =
        'https://meal-admin-app-default-rtdb.firebaseio.com/categories.json';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        final List<Categories> loadedCategories = [];
        extractedData.forEach((categoryId, categoryData) {
          // print(categoryData['entries']);
          loadedCategories.add(
            Categories(
              id: categoryId,
              name: categoryData['name'],
              entries: [],
            ),
          );
        });
        return loadedCategories;
      } else {
        throw 'Something Happend';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addShopInfo(Map<String, dynamic> data) async {
    String url = 'https://meal-admin-app-default-rtdb.firebaseio.com/info.json';

    try {
      final response = await http.put(
        Uri.parse(url),
        body: json.encode(data),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        throw 'Данные не добавлены';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ShopModel> getShopInfo() async {
    String url = 'https://meal-admin-app-default-rtdb.firebaseio.com/info.json';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body);
        return ShopModel.fromJson(extractedData);
      } else {
        throw 'No data';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addMeal(Map<String, dynamic> data, String id) async {
    String url =
        'https://meal-admin-app-default-rtdb.firebaseio.com/categories/$id/entries.json';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(data),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }
}
