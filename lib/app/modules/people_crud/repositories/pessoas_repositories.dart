import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/pessoa_model.dart';

class PessoasRepositories {
  Future<PersonModel> findAllPeople() async {
    Stream<QuerySnapshot> _peopleStream = FirebaseFirestore.instance.collection('people').snapshots();
    return _peopleStream as Future<PersonModel>;
  }
}
// Future<ExtratoModel?> findContaUnica(String fidelidade, EmpresaModel empresa) async {
//     FirebaseFirestore _firebase = FirebaseFirestore.instance;
//     final QuerySnapshot<Map<String, dynamic>> _resposta = await _firebase.collection('conta').where('empresa.cnpj', isEqualTo: empresa.cnpj).where('id_conta', isEqualTo: fidelidade).get();
//     if (_resposta.docs.isNotEmpty) {
//       return ExtratoModel.fromJson(_resposta.docs.first.data());
//     }
//     return null;
//   }