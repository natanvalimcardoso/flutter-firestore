import 'package:flutter_firestore/app/modules/people_crud/repositories/pessoas_repositories.dart';

class ControllerPessoas {
  final _pessoasRepository = PessoasRepositories();

  createPeople({required String name, required String email, required int age}) async {
    return await _pessoasRepository.createPeople(name: name, email: email, age: age);
  }

  deletePeople({required String id}) async {
    return await _pessoasRepository.deletePeople(id: id);
  }

  updatePeople(
      {required String id, required String name, required String email, required int age}) async {
    return await _pessoasRepository.updatePeople(id: id, name: name, email: email, age: age);
  }
}
