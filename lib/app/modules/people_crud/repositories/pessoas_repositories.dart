import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import '../model/pessoa_model.dart';

class PessoasRepositories {
  Stream<List<PersonModel>> readFirebase() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference people = firestore.collection('people');
    return people.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return PersonModel.fromMap(doc.get('people'));
      }).toList();
    });
  }
}
