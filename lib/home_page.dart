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
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 100,
              right: 50,
              left: 50,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.add_home_outlined, size: 30),
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
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            Positioned(
              top: 200,
              right: 50,
              left: 50,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddCategoryPage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.menu_book,
                  size: 30,
                ),
                label: const Text(
                  'Добавить Категории блюд',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            Positioned(
              top: 300,
              right: 50,
              left: 50,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddMealPage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.food_bank_outlined,
                  size: 30,
                ),
                label: const Text(
                  'Добавить Блюда',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
      // drawer: Drawer(
      //   backgroundColor: Colors.white,
      //   child: ListView(
      //     shrinkWrap: true,
      //     children: [

      //     ],
      //   ),
      // ),
    );
  }
}
