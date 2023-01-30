import 'package:flutter/material.dart';
import 'package:meal_admin_app/repository/provider_repository.dart';
import 'package:meal_admin_app/widgets/category_list_widget.dart';

class AddCategoryWidget extends StatefulWidget {
  const AddCategoryWidget({super.key});

  @override
  State<AddCategoryWidget> createState() => _AddCategoryWidgetState();
}

class _AddCategoryWidgetState extends State<AddCategoryWidget> {
  Color primaryColor = Colors.blue;
  TextEditingController categoryController = TextEditingController();
  ProviderRepository providerRepository = ProviderRepository();
  String inputData = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            children: [
              TextFormField(
                controller: categoryController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      inputData = categoryController.text;
                      providerRepository.addCategory(inputData);
                      categoryController.clear();
                    },
                    icon: const Icon(Icons.keyboard_arrow_right_outlined),
                  ),
                  label: const Text('Введите название категории'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              CategoryListWidget(),

              // ListView.builder(
              //   itemBuilder: (context, index) {},
              // )
              // const SizedBox(
              //   height: 10,
              // ),
              // OutlinedButton.icon(
              //   onPressed: () {},
              //   icon: const Icon(Icons.add),
              //   label: const Text('Добавить блюдо'),
              // ),
              // ListView(
              //   shrinkWrap: true,
              //   children: List.generate(
              //     growable: true,
              //     _dataCategories.length,
              //     (index) {
              //       return ;
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
