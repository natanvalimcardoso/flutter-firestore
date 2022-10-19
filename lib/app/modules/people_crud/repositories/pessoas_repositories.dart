import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/pessoa_model.dart';

class PessoasRepositories {

  Future createPeople({required String name, required String email, required int age}) async {
    final sendPeopleFirebase = FirebaseFirestore.instance.collection('people').doc();
    final people = PersonModel(id: sendPeopleFirebase.id, name: name, email: email, age: age);
    final json = people.toMap();
    await sendPeopleFirebase.set(json);
  }

  Future deletePeople({required String id}) async {
    final deletePeopleFirebase = FirebaseFirestore.instance.collection('people').doc(id);
    await deletePeopleFirebase.delete();
  }

  Future updatePeople(
      {required String id, required String name, required String email, required int age}) async {
    final sendPeopleFirebase = FirebaseFirestore.instance.collection('people').doc(id);
    final people = PersonModel(id: id, name: name, email: email, age: age);
    final json = people.toMap();
    await sendPeopleFirebase.update(json);
  }
}
