import 'package:flutter/material.dart';
import 'package:meal_admin_app/widgets/add_meal_widget.dart';

import '../widgets/meal_list_widget.dart';
import '../widgets/upload_images_widget.dart';

class AddMealPage extends StatefulWidget {
  const AddMealPage({super.key});

  @override
  State<AddMealPage> createState() => _AddMealPageState();
}

class _AddMealPageState extends State<AddMealPage> {
  Color primaryColor = Colors.blue;
  bool toAddMeal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить блюдо'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                toAddMeal = !toAddMeal;
              });
            },
            icon: const Icon(Icons.format_list_bulleted_add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: primaryColor,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                toAddMeal ? AddMealWidget() : MealListWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
