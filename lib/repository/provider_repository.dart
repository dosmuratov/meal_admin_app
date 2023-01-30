import 'dart:convert';

import 'package:http/http.dart' as http;

class ProviderRepository {
  void addCategory(String category) async {
    String url =
        'https://meal-admin-app-default-rtdb.firebaseio.com/categories.json';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          "category": category,
        }),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<List<String>> getListCategories() async {
    String url =
        'https://meal-admin-app-default-rtdb.firebaseio.com/categories.json';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        final List<String> loadedCategories = [];
        extractedData.forEach((key, value) {
          loadedCategories.add(value['category']);
        });
        print(loadedCategories);
        return loadedCategories;
      } else {
        print(response.statusCode);
        return [];
      }
      ;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
