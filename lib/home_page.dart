import 'package:flutter/material.dart';
import 'package:meal_admin_app/pages/add_meal_page.dart';

import 'pages/about_cafe_page.dart';
import 'pages/add_category_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Административная панель'),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Text(''),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          shrinkWrap: true,
          children: [
            OutlinedButton.icon(
              icon: const Icon(Icons.add_home_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutCafePage(),
                  ),
                );
              },
              label: const Text(
                'О Заведении',
              ),
            ),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddCategoryPage(),
                  ),
                );
              },
              icon: const Icon(Icons.menu_book),
              label: const Text('Добавить Категории блюд'),
            ),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddMealPage(),
                    ));
              },
              icon: const Icon(Icons.food_bank_outlined),
              label: const Text('Добавить Блюда'),
            ),
          ],
        ),
      ),
    );
  }
}
