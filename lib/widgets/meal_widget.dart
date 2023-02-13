import 'package:flutter/material.dart';
import 'package:meal_admin_app/repository/provider_repository.dart';

import '../models/meal.dart';

class MealWidget extends StatefulWidget {
  const MealWidget({
    super.key,
    required this.categoryId,
  });
  final String categoryId;
  @override
  State<MealWidget> createState() => _MealWidgetState();
}

class _MealWidgetState extends State<MealWidget> {
  Color primaryColor = Colors.blue;
  bool toAddChecker = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<List<Meal>> futureListOfMeals =
        ProviderRepository().getMealFromCategoryId(widget.categoryId);
    return FutureBuilder(
      future: futureListOfMeals,
      builder: (context, snapshot) {
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return const Text('Ожидание');
        // }
        if (snapshot.connectionState == ConnectionState.done) {
          final listOfMeals = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(40.0),
            child: ListView.builder(
              primary: false,
              padding: const EdgeInsets.all(10),
              shrinkWrap: true,
              itemCount: listOfMeals.length,
              itemBuilder: (context, index) {
                Meal meal = listOfMeals.elementAt(index);
                // print(meal);
                return ListView(
                  padding: const EdgeInsets.only(bottom: 20, right: 30),
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      readOnly: !toAddChecker,
                      decoration: InputDecoration(
                        label: toAddChecker
                            ? const Text('Название блюда')
                            : Text(meal.name),
                        border: toAddChecker
                            ? OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: primaryColor,
                                ),
                              )
                            : const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                      ),
                    ),
                    TextFormField(
                      readOnly: !toAddChecker,
                      decoration: InputDecoration(
                        label: toAddChecker
                            ? const Text('Описание блюда')
                            : Text(meal.description),
                        border: toAddChecker
                            ? OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: primaryColor,
                                ),
                              )
                            : const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                      ),
                    ),
                    TextFormField(
                      readOnly: !toAddChecker,
                      decoration: InputDecoration(
                        label: toAddChecker
                            ? const Text('Цена')
                            : Text(meal.price.toString()),
                        border: toAddChecker
                            ? OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: primaryColor,
                                ),
                              )
                            : const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                      ),
                    ),
                    meal.imageUrl.isNotEmpty
                        ? Image.network(meal.imageUrl)
                        : const Center(),
                  ],
                );
              },
              // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //   crossAxisCount: 2,
              // ),
            ),
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
