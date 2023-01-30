import 'package:flutter/material.dart';
import 'package:meal_admin_app/widgets/add_category_widget.dart';

import 'add_meal_page.dart';

class AddMenuPage extends StatefulWidget {
  const AddMenuPage({super.key});

  @override
  State<AddMenuPage> createState() => _AddMenuPageState();
}

class _AddMenuPageState extends State<AddMenuPage> {
  Color primaryColor = Colors.blue;

  int textFields = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить Меню'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AddCategoryWidget(),
          ],
        ),
      ),
    );
  }
}

// Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(
//                       color: primaryColor,
//                     ),
//                   ),
//                   child: SizedBox(
//                     width: 10,
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         label: const Text('Введите название'),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(
//                             color: primaryColor,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );