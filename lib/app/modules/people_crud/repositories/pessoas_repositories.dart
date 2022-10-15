import 'package:cloud_firestore/cloud_firestore.dart';


class PessoasRepositories {
  readFirebase(){
      var people = FirebaseFirestore.instance.collection('people').snapshots();
      return people;
  }
}
