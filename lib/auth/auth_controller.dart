import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:mymusic/models/User.dart' as model;

class AuthController extends ChangeNotifier {
  Future<model.User?> user() async {
    User? fireUser = FirebaseAuth.instance.currentUser;
    if (fireUser != null) {
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(fireUser.uid)
          .get();
      return model.User.fromSnap(snap);
    } else {
      return null;
    }
  }

  Future<String> _storeImage(String uid, File image) async {
    Reference ref =
        FirebaseStorage.instance.ref().child("profilePics").child(uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future registerUser(String email, String username, String password) async {
    try {
      if (email.isNotEmpty && username.isNotEmpty && password.isNotEmpty) {
        UserCredential cred = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        model.User user =
            model.User(username: username, uid: cred.user!.uid, email: email);
        FirebaseFirestore.instance
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());
      } else {
        print("Error missing fields");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<model.User> loginUser(String email, String password) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      UserCredential cred = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      model.User user = model.User.fromSnap(await FirebaseFirestore.instance
          .collection('users')
          .doc(cred.user!.uid)
          .get());
      //print(sub);
      return user;
    } else {
      throw "Missing Fields";
    }
  }

  Future logoutUser() async {
    await FirebaseAuth.instance.signOut();
  }
}
