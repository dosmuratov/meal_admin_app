import 'package:flutter/material.dart';
import 'package:meal_admin_app/pages/add_meal_page.dart';
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
  String imageUrl = '';
  Map<String, dynamic> data = {};

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Categories>> listOfCategories =
        ProviderRepository().getListCategories();
    return Form(
      key: formKey,
      child: Column(
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
              onSaved: (newValue) {
                data.addAll({'Название': newValue});
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
            ),
            child: TextFormField(
              maxLines: 5,
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
              onSaved: (newValue) {
                data.addAll({'Описание': newValue});
              },
            ),
          ),
          FutureBuilder(
            future: listOfCategories,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var snapData = snapshot.data!;
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 20.0,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: primaryColor,
                        ),
                      ),
                      child: DropdownButtonFormField(
                        items: snapData.map((element) {
                          return DropdownMenuItem(
                            value: element.name,
                            child: Text(element.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                        value: selectedCategory,
                        validator: (value) {
                          if (value == null) {
                            return 'Введите категорию блюда';
                          } else {
                            return null;
                          }
                        },
                        hint: const Text('Категории'),
                        onSaved: (newValue) {
                          data.addAll({
                            'Категория': snapData
                                .map((el) => el.name == newValue ? el.id : '')
                                .toString(),
                          });
                        },
                      ),
                    ),
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          UploadImagesWidget(
            imageUrl: (value) {
              if (value.isNotEmpty) {
                data.addAll({'imageUrl': value});
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Выберите рисунок и Загрузите'),
                  ),
                );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton.icon(
              onPressed: onSaved,
              icon: const Icon(Icons.save_alt_outlined),
              label: const Text('Добавить блюдо'),
            ),
          ),
        ],
      ),
    );
  }

  void onSaved() //String string)
  {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
      var daddd = data['Категория'] as String;
      var index = daddd.indexOf('-');
      var newst = daddd.substring(index, index + 20);
      data.update(
        'Категория',
        (value) => newst,
      );

      ProviderRepository().addMeal(data, newst);
      Navigator.pop(
        context,
        MaterialPageRoute(
          builder: (context) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Блюдо добавлено'),
              ),
            );
            return const AddMealPage();
          },
        ),
      );
    }
  }
}
