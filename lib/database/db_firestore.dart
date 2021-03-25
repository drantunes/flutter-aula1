import 'package:cloud_firestore/cloud_firestore.dart';

class DBFirestore {
  DBFirestore._();
  static final DBFirestore _instance = DBFirestore._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static get() {
    return DBFirestore._instance._firestore;
  }
}
