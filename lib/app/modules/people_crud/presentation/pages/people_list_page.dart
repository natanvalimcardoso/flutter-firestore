import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore/app/modules/people_crud/presentation/widgets/header_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../domain/model/pessoa_model.dart';
import '../widgets/modal_container_widget.dart';

class PeopleListPage extends StatefulWidget {
  const PeopleListPage({Key? key}) : super(key: key);

  @override
  State<PeopleListPage> createState() => _PeopleListPageState();
}

final TextEditingController _nameController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _ageController = TextEditingController();

Future createName({required String name, required String email, required int age}) async {
  final sendPeopleFirebase = FirebaseFirestore.instance.collection('people').doc();
  final people = PersonModel(id: sendPeopleFirebase.id, name: name, email: email, age: age);
  final json = people.toMap();
  await sendPeopleFirebase.set(json);
}



class _PeopleListPageState extends State<PeopleListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HeaderWidget(),
          SizedBox(
            height: 550,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showMaterialModalBottomSheet(
            context: context,
            builder: (context) => Container(
              height: 350,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 50,
                ),
                child:  ModalContainerWidget(
                  onTap: () {
                    createName(
                      name: _nameController.text,
                      email: _emailController.text,
                      age: int.parse(_ageController.text),
                    );
                    Modular.to.pop();
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
