import 'package:flutter/material.dart';
import 'package:meal_admin_app/repository/provider_repository.dart';

class AddCategoryWidget extends StatefulWidget {
  const AddCategoryWidget({super.key});

  @override
  State<AddCategoryWidget> createState() => _AddCategoryWidgetState();
}

class _AddCategoryWidgetState extends State<AddCategoryWidget> {
  Color primaryColor = Colors.blue;
  Map<String, dynamic> _dataCategories = {};
  TextEditingController categoryController = TextEditingController();

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
        child: ListView(
          shrinkWrap: true,
          children: [
            TextFormField(
              controller: categoryController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () async {
                    final cc = ProviderRepository();
                    var dd = categoryController.text;
                    cc.addCategory(dd);
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
    );
  }
}
