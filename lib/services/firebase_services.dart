import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  CollectionReference productReference =
  FirebaseFirestore.instance.collection("Products");

  CollectionReference userReference =
  FirebaseFirestore.instance.collection("Users");

  String getUserID(){
    return firebaseAuth.currentUser.uid;
  }

}