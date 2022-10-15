import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../model/pessoa_model.dart';
import '../widgets/card_firebase_widget.dart';
import '../widgets/header_widget.dart';
import '../widgets/modal_container_widget.dart';

class PeopleListPage extends StatefulWidget {
  const PeopleListPage({Key? key}) : super(key: key);

  @override
  State<PeopleListPage> createState() => _PeopleListPageState();
}

final TextEditingController _nameController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _ageController = TextEditingController();

//? ----------------------------|| CRUD  ||-------------------------------- //?

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

final Stream<QuerySnapshot> _peopleStream = FirebaseFirestore.instance.collection('people').snapshots();

//? ----------------------------|| CRUD  ||-------------------------------- //?

cleanTextFields() {
  _nameController.clear();
  _emailController.clear();
  _ageController.clear();
}

class _PeopleListPageState extends State<PeopleListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeaderWidget(),
            StreamBuilder(
              stream: _peopleStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return SizedBox(
                  height: 500,
                  child: ListView( //! transformar em ListView.builder
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      var data = document.data()! as Map<String, dynamic>;
                      var people = PersonModel.fromMap(data);
                      return CardFirebaseWidget(
                          name: people.name,
                          email: people.email,
                          age: people.age,
                          deletePeopleOnTap: () {
                            deletePeople(id: data['id']);
                          });
                    }).toList(),
                  ),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          showMaterialModalBottomSheet(
            context: context,
            builder: (context) => SizedBox(
              height: 620,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 50,
                ),
                child: ModalContainerWidget(
                  onTap: () {
                    createPeople(
                      name: _nameController.text,
                      email: _emailController.text,
                      age: int.parse(_ageController.text),
                    );
                    Modular.to.pop();
                    cleanTextFields();
                  },
                  nameController: _nameController,
                  emailController: _emailController,
                  ageController: _ageController,
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
