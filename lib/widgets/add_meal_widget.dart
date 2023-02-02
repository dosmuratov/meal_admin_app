import 'package:flutter/material.dart';
import 'package:meal_admin_app/repository/provider_repository.dart';

import '../models/categories.dart';
import 'upload_images_widget.dart';

class AddMealWidget extends StatefulWidget {
  const AddMealWidget({super.key});

  @override
  State<AddMealWidget> createState() => _AddMealWidgetState();
}

class _AddMealWidgetState extends State<AddMealWidget> {
  Color primaryColor = Colors.blue;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? selectedCategory;
  bool mealAdded = false;
  Future<List<Categories>> listOfCategories =
      ProviderRepository().getListCategories();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: TextFormField(
            validator: (value) {
              if (value == null) {
                return 'Введите название блюда';
              } else {
                return null;
              }
            },
            controller: nameController,
            decoration: InputDecoration(
              label: const Text('Название блюда'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            bottom: 10.0,
          ),
          child: TextFormField(
            validator: (value) {
              if (value == null) {
                return 'Введите описание блюда';
              } else {
                return null;
              }
            },
            controller: descriptionController,
            decoration: InputDecoration(
              label: const Text('Описание блюда'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ),
        FutureBuilder(
          future: listOfCategories,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data!;
              return SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      DropdownButtonFormField(
                        items: data
                            .map(
                              (element) => DropdownMenuItem(
                                value: element.name,
                                child: Text(element.name),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                        value: selectedCategory,
                        validator: (value) {
                          if (value == null) {
                            return 'Введите описание блюда';
                          } else {
                            return null;
                          }
                        },
                      ),
                      UploadImagesWidget(
                        name: nameController.text,
                        description: descriptionController.text,
                        onSuccess: (value) {
                          formKey.currentState!.validate();

                          if (value) {
                            nameController.clear();
                            descriptionController.clear();
                            print('$value from add_meal_widget');
                            setState(() {
                              mealAdded = value;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Блюдо добавлено'),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return TextFormField();
            }
          },
        ),
      ],
    );
  }
}
