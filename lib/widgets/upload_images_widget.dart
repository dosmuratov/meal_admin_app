import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:meal_admin_app/repository/provider_repository.dart';
import 'package:path/path.dart';
import '../api/firebase_api.dart';

class UploadImagesWidget extends StatefulWidget {
  const UploadImagesWidget({
    super.key,
    required this.name,
    required this.description,
    required this.onSuccess,
  });
  final String name;
  final String description;
  final ValueChanged<bool> onSuccess;

  @override
  State<UploadImagesWidget> createState() => _UploadImagesWidgetState();
}

class _UploadImagesWidgetState extends State<UploadImagesWidget> {
  Color primaryColor = Colors.blue;
  File? file;
  UploadTask? task;

  @override
  Widget build(BuildContext context) {
    // final fileName =
    //     file != null ? basename(file!.path) : 'Нет загруженных файлов';
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: primaryColor,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            OutlinedButton.icon(
              onPressed: selectFile,
              icon: const Icon(Icons.attach_file),
              label: const Text('Выберите файл'),
            ),
            Container(
              child: file != null
                  ? Image.file(file!)
                  : const Text('Нет загруженных файлов'),
            ),
            const SizedBox(
              height: 10,
            ),
            OutlinedButton.icon(
              onPressed: uploadFile,
              icon: const Icon(Icons.cloud_upload_outlined),
              label: const Text('Сохранить'),
            ),
            // const MealListWidget(),
            task != null ? buildUploadStatus(task!) : Container(),
            // if ()
          ],
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path;
    setState(() => file = File(path!));
  }

  Future uploadFile() async {
    if (file == null) return;
    final fileName = basename(file!.path);
    final destination = 'files/$fileName';
    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});
    if (task == null) return;
    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    final result = await ProviderRepository().addMeal({
      'name': widget.name,
      'description': widget.description,
      'imageUrl': urlDownload,
    });

    print(result);
    widget.onSuccess(result);
    setState(() {
      task = null;
    });

    // print(urlDownload);
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toString();

            return Text(percentage);
          } else {
            return Container();
          }
        },
      );
}
