import 'package:flutter/material.dart';
import 'package:meal_admin_app/repository/provider_repository.dart';

class AddCategoryWidget extends StatefulWidget {
  const AddCategoryWidget({
    super.key,
    required this.isDone,
  });
  final ValueChanged<bool> isDone;

  @override
  State<AddCategoryWidget> createState() => _AddCategoryWidgetState();
}

class _AddCategoryWidgetState extends State<AddCategoryWidget> {
  Color primaryColor = Colors.blue;
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: categoryController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      ProviderRepository().addCategory(categoryController.text);
                      categoryController.clear();
                      widget.isDone(true);
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
            ],
          ),
        ),
      ),
    );
  }
}
