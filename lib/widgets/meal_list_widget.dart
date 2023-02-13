import 'package:flutter/material.dart';

import '../models/categories.dart';
import '../repository/provider_repository.dart';
import 'meal_widget.dart';

class MealListWidget extends StatefulWidget {
  const MealListWidget({super.key});

  @override
  State<MealListWidget> createState() => _MealListWidgetState();
}

class _MealListWidgetState extends State<MealListWidget> {
  Color primaryColor = Colors.blue;
  bool isTileOpened = false;

  @override
  Widget build(BuildContext context) {
    Future<List<Categories>> listOfCategories =
        ProviderRepository().getListCategories();

    return FutureBuilder(
      future: listOfCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final datas = snapshot.data!;
          return ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final mealId = datas.elementAt(index).id;
              final mealName = datas.elementAt(index).name;
              return ExpansionTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  mealName,
                ),
                children: [
                  MealWidget(categoryId: mealId),
                ], //MealWidget(categoryId: mealId),
              );
            },
            itemCount: datas.length,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
