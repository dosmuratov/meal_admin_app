import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import '../api/firebase_api.dart';

class UploadImagesWidget extends StatefulWidget {
  const UploadImagesWidget({
    super.key,
    required this.imageUrl,
  });
  final ValueChanged<String> imageUrl;

  @override
  State<UploadImagesWidget> createState() => _UploadImagesWidgetState();
}

class _UploadImagesWidgetState extends State<UploadImagesWidget> {
  Color primaryColor = Colors.blue;
  File? file;
  UploadTask? task;
  List<String> addedImages = [];

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
            file != null
                ? OutlinedButton.icon(
                    onPressed: uploadFile,
                    icon: const Icon(Icons.cloud_upload_outlined),
                    label: const Text('Загрузить'),
                  )
                : const Center(),
            task != null ? buildUploadStatus(task!) : Container(),
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
    if (addedImages.contains(file!.path)) {
      return;
    }
    final fileName = basename(file!.path);
    final destination = 'files/$fileName';
    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});
    if (task == null) return;
    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    widget.imageUrl(urlDownload);

    addedImages.add(file!.path);

    setState(() {
      task = null;
    });
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
