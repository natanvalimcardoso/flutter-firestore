import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../controller/controller_pessoas.dart';
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

final Stream<QuerySnapshot> _peopleStream =
    FirebaseFirestore.instance.collection('people').snapshots();

cleanTextFields() {
  _nameController.clear();
  _emailController.clear();
  _ageController.clear();
}

final _controllerPeople = ControllerPessoas();
final _formKey = GlobalKey<FormState>();

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
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index].data()! as Map<String, dynamic>;
                      var people = PersonModel.fromMap(data);
                      return CardFirebaseWidget(
                        name: people.name,
                        email: people.email,
                        age: people.age,
                        deletePeopleOnTap: () {
                          _controllerPeople.deletePeople(id: people.id);
                        },
                        updatePeopleOnTap: () {
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
                                    if (_formKey.currentState!.validate() &&
                                        _nameController.text.isNotEmpty &&
                                        _emailController.text.isNotEmpty &&
                                        _ageController.text.isNotEmpty) {
                                      _controllerPeople.updatePeople(
                                        id: data['id'],
                                        name: _nameController.text,
                                        email: _emailController.text,
                                        age: int.parse(_ageController.text),
                                      );
                                      Modular.to.pop();
                                      cleanTextFields();
                                    }
                                  },
                                  nameController: _nameController,
                                  emailController: _emailController,
                                  ageController: _ageController,
                                  title: 'Atualizar Pessoa',
                                  formKey: _formKey,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
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
                  formKey: _formKey,
                  onTap: () {
                    if (_formKey.currentState!.validate() &&
                        _nameController.text.isNotEmpty &&
                        _emailController.text.isNotEmpty &&
                        _ageController.text.isNotEmpty) {
                      _controllerPeople.createPeople(
                        name: _nameController.text,
                        email: _emailController.text,
                        age: int.parse(_ageController.text),
                      );
                      Modular.to.pop();
                      cleanTextFields();
                    }
                  },
                  nameController: _nameController,
                  emailController: _emailController,
                  ageController: _ageController,
                  title: 'Adicionar Pessoa',
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
