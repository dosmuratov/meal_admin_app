import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import '../api/firebase_api.dart';

class UploadFilesToFirebaseStorage {
  final File file;

  UploadFilesToFirebaseStorage(this.file);

  UploadTask? task;

  Future<String> uploadFile(File file) async {
    // if (file == null) return;

    final fileName = basename(file.path);
    final destination = 'files/$fileName';

    try {
      task = FirebaseApi.uploadFile(destination, file);
    } catch (e) {
      rethrow;
    }

    // if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    // widget.imageUrl(urlDownload);
    return urlDownload;
  }
}
