import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import '../model/pessoa_model.dart';

class PessoasRepositories {
  readFirebase(){
      var people = FirebaseFirestore.instance.collection('people').snapshots();
      return people;
  }
}
