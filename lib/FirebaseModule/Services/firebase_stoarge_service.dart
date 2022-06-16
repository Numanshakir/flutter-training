import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'package:firebase_core/firebase_core.dart';

class FireStorageImageService {
  ///TODO:Firebase rules
//   rules_version = '2';
//   service firebase.storage {
//   match /b/{bucket}/o {
//   match /{allPaths=**} {
//   allow read, write: if request.auth != null;
//   }
// }
// }
  Future<String> uploadImageToFirebase(
      BuildContext context, String imagePath) async {
    // FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await Firebase.initializeApp();

      FirebaseAuth.instance.authStateChanges().listen((User? user) async {
        if (user == null) {
          print('User is currently signed out!');
          FirebaseAuth auth = FirebaseAuth.instance;
          // await auth.signInAnonymously();
          await auth.signInAnonymously();
          // FirebaseApp secondaryApp = Firebase.app('SecondaryApp');
          // FirebaseAuth auth = FirebaseAuth.instanceFor(app: secondaryApp);
          print(auth.currentUser);
        } else {
          print('User is signed in!');
        }
      });
      // FirebaseAuth mAuth = FirebaseAuth.instance.;

      print("Upload image");
      String fileName = basename(imagePath);
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('uploads')
          .child('/$fileName');
      print(ref);

      final metadata = firebase_storage.SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'picked-file-path': fileName});
      print(metadata);
      firebase_storage.TaskSnapshot uploadTask;
      //late StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
      uploadTask = await ref
          .putFile(io.File(imagePath), metadata)
          .whenComplete(() => {});

      print(uploadTask);

      String downloadURL = await uploadTask.ref.getDownloadURL();

      print("imageURL");
      print(downloadURL);

      return downloadURL;
      // return "";
    } catch (e) {
      return "";
    }
  }

}
