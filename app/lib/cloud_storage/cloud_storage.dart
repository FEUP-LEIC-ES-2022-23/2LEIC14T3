import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CloudStorage {
  final PlatformFile? pickedFile;
  UploadTask? uploadTask;
  CloudStorage({
    required this.pickedFile,
  });

  Future<String> uploadImage() async {
    final path = 'profile_pics/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    return urlDownload;
  }
}