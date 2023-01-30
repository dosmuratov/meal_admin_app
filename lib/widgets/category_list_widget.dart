import 'package:flutter/material.dart';
import 'package:meal_admin_app/repository/provider_repository.dart';

class CategoryListWidget extends StatefulWidget {
  const CategoryListWidget({
    super.key,
  });

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  Future<List<String>> listOfCategories =
      ProviderRepository().getListCategories();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: listOfCategories,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!;
          return ListOfCategories(
            list: data,
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class ListOfCategories extends StatelessWidget {
  const ListOfCategories({
    super.key,
    required this.list,
  });
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) => Text(
        list.elementAt(index),
      ),
      itemCount: list.length,
    );
  }
}
