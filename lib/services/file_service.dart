import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_firebase_ui/services/pref_service.dart';


class FileService {
  static final _storage = FirebaseStorage.instance.ref();
  static const folderPost = "post_images";
  static const folderUser = "user_images";

  static Future<String?> uploadUserImage(File _image) async {
    String uid = HiveDB.loadUid();
    String imgName = uid;
    Reference firebaseStorageRef = _storage.child(folderUser).child(imgName);
    UploadTask uploadTask = firebaseStorageRef.putFile(_image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  static Future<String?> uploadPostImage(File? _image) async {
    if (_image == null) return null;
    String uid = HiveDB.loadUid();
    String imgName = "file_${DateTime.now()}";
    Reference firebaseStorageRef = _storage.child(folderPost).child(imgName);
    UploadTask uploadTask = firebaseStorageRef.putFile(_image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
