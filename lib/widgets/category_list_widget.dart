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
              final id = data.elementAt(index).id;

              return ListTile(
                trailing: IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        action: SnackBarAction(
                          label: 'Удалить',
                          onPressed: () async {
                            final response =
                                await ProviderRepository().deleteCategory(id);
                            if (response) {
                              ScaffoldMessenger.of(context)
                                ..clearSnackBars()
                                ..showSnackBar(
                                  const SnackBar(
                                    content: Text('Успешно удалено'),
                                  ),
                                );
                              Navigator.pop(context);
                            }
                          },
                        ),
                        content: const Text('Вы уверены?'),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                  ),
                ),
                title: Text(name),
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
