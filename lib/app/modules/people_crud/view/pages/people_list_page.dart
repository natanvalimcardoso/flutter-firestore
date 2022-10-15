import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore/app/modules/people_crud/view/widgets/header_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../controller/controller_pessoas.dart';
import '../../model/pessoa_model.dart';
import '../widgets/modal_container_widget.dart';

class PeopleListPage extends StatefulWidget {
  const PeopleListPage({Key? key}) : super(key: key);

  @override
  State<PeopleListPage> createState() => _PeopleListPageState();
}

final TextEditingController _nameController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _ageController = TextEditingController();

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

final Stream<QuerySnapshot> _peopleStream =
    FirebaseFirestore.instance.collection('people').snapshots();

cleanTextFields() {
  _nameController.clear();
  _emailController.clear();
  _ageController.clear();
}

class _PeopleListPageState extends State<PeopleListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HeaderWidget(),
          StreamBuilder(
            stream: _peopleStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }

              return SizedBox(
                height: 500,
                child: ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    var data = document.data()! as Map<String, dynamic>;
                    return Card(
                      child: Container(
                        height: 80,
                        child: Column(
                          children: [
                            Container(
                              height: 25,
                              color: Color.fromARGB(255, 240, 238, 238),
                              child: Row(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      'Nome',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 105),
                                    child: Text(
                                      'Email',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 70),
                                    child: Text(
                                      'Idade',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 40),
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  alignment: Alignment.center,
                                  width: 85,
                                  child: Text(
                                    data['name'],
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  width: 160,
                                  alignment: Alignment.center,
                                  child: Text(
                                    data['email'],
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  width: 30,
                                  alignment: Alignment.center,
                                  child: Text(
                                    data['age'].toString(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 40),
                                  child: IconButton(
                                    onPressed: () {
                                      deletePeople(id: data['id']);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          showMaterialModalBottomSheet(
            context: context,
            builder: (context) => Container(
              height: 350,
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
