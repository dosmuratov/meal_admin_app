import 'package:flutter/material.dart';
import 'package:meal_admin_app/models/categories.dart';
import 'package:meal_admin_app/repository/provider_repository.dart';

class CategoryListWidget extends StatefulWidget {
  const CategoryListWidget({
    super.key,
  });

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  @override
  Widget build(BuildContext context) {
    Future<List<Categories>> listOfCategories =
        ProviderRepository().getListCategories();

    return FutureBuilder(
      future: listOfCategories,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final name = data.elementAt(index).name;
              final entries = data.elementAt(index).entries;

              return ListTile(
                title: Text(name),
                trailing: Text(entries.toString()),
              );
            },
            itemCount: data.length,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
