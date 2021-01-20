
import 'package:firebase_storage/firebase_storage.dart';

Future<void> deletePostImage(String imageFileUrl) async {
  try {
    String fileName = imageFileUrl.replaceAll("/o/", "*");
    fileName = fileName.replaceAll("?", "*");
    fileName = fileName.split("*")[1];
    print(fileName);
    final firebaseStorageRef =
    FirebaseStorage.instance.ref().child(fileName);
    await firebaseStorageRef.delete();
  } catch (e) {
    print(e.message);
  }
}
