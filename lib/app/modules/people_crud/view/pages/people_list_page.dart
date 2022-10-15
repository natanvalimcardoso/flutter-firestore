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

Future createName({required String name, required String email, required int age}) async {
  final sendPeopleFirebase = FirebaseFirestore.instance.collection('people').doc();
  final people = PersonModel(id: sendPeopleFirebase.id, name: name, email: email, age: age);
  final json = people.toMap();
  await sendPeopleFirebase.set(json);
}

    CollectionReference people = FirebaseFirestore.instance.collection('people');


class _PeopleListPageState extends State<PeopleListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HeaderWidget(),
          StreamBuilder<QuerySnapshot>(
            stream: people.snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return SizedBox(
                height: 500,
                child: ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    return ListTile(
                      title: Text(data['name']),
                      subtitle: Text(data['email']),
                    );
                  }).toList(),
                ),
              );
            },
          )
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
                child: ModalContainerWidget(
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







// StreamBuilder(
//             stream: _controllerPessoas.findAll(),
//             builder: (context, AsyncSnapshot<Stream<List<PersonModel>>> snapshot) {
//               if (snapshot.hasData) {
//                 return StreamBuilder(
//                   stream: snapshot.data,
//                   builder: (context, AsyncSnapshot<List<PersonModel>> snapshot) {
//                     if (snapshot.hasData) {
//                       return SizedBox(
//                         height:400,
                        
//                         child: ListView.builder(
//                           itemCount: snapshot.data!.length,
//                           itemBuilder: (context, index) {
//                             final people = snapshot.data![index];
//                             return ListTile(
//                               title: Text(people.name),
//                               subtitle: Text(people.email),
//                               trailing: Text(people.age.toString()),
//                             );
//                           },
//                         ),
//                       );
//                     } else {
//                       return const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     }
//                   },
//                 );
//               } else {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//             },
//           ),