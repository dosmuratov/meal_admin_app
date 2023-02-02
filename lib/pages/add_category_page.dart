import 'package:flutter/material.dart';
import 'package:meal_admin_app/widgets/add_category_widget.dart';

import '../widgets/category_list_widget.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddMenuPageState();
}

class _AddMenuPageState extends State<AddCategoryPage> {
  Color primaryColor = Colors.blue;
  bool showForm = false;
  int textFields = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Категории блюд'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                showForm = !showForm;
              });
            },
            icon: const Icon(Icons.post_add_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            showForm
                ? AddCategoryWidget(
                    isDone: (bool value) {
                      setState(() {
                        showForm = false;
                      });
                    },
                  )
                : const CategoryListWidget(),
          ],
        ),
      ),
    );
  }
}
