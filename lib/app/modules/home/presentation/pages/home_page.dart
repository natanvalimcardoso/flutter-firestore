import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore/app/modules/home/domain/model/pessoa_model.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  Future createName({
    required String name,
    required String email,
    required int age,

  }) async {
    final sendPeopleFirebase = FirebaseFirestore.instance.collection('name').doc();

    final people = PessoaModel(id: sendPeopleFirebase.id, name: name, email: email, age: age);
    final json = people.toMap();

    await sendPeopleFirebase.set(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                labelText: 'Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                labelText: 'Email',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _ageController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                labelText: 'Age',
              ),
            ),
          ),
          ElevatedButton(
            child: const Text('Enviar'),
            onPressed: () {
              final name = _nameController.text;
              final email = _emailController.text;
              final age = _ageController.text;
              final ageConvert = int.parse(age);
              createName(name: name, email: email, age: ageConvert);
            },
          )
        ],
      ),
    );
  }
}
