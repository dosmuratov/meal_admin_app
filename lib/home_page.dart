import 'package:flutter/material.dart';

import 'pages/about_cafe_page.dart';
import 'pages/add_menu_page.dart';

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
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutCafePage(),
                  ),
                );
              },
              child: const Text(
                'О Заведении',
              ),
            ),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddMenuPage(),
                  ),
                );
              },
              icon: const Icon(Icons.add_business_outlined),
              label: const Text('Добавить Меню'),
            ),
          ],
        ),
      ),
    );
  }
}
