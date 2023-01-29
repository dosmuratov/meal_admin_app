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
          "category": "$category",
        }),
      );
      print(json.decode(response.body));
    } catch (e) {
      print(e);
    }
  }
}
