import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class MealListWidget extends StatefulWidget {
  const MealListWidget({super.key});

  @override
  State<MealListWidget> createState() => _MealListWidgetState();
}

class _MealListWidgetState extends State<MealListWidget> {
  late Future<ListResult> futureFiles;
  Color primaryColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    futureFiles = FirebaseStorage.instance.ref('/files').listAll();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: primaryColor,
        ),
      ),
      child: FutureBuilder<ListResult>(
        future: futureFiles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final files = snapshot.data!.items;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: files.length,
              itemBuilder: (context, index) {
                final file = files[index];
                return ListTile(
                  title: Text(file.name),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Ошибка'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
