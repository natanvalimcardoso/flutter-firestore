import 'package:flutter_firestore/app/modules/people_crud/repositories/pessoas_repositories.dart';

class ControllerPessoas {
  final _pessoasRepository = PessoasRepositories();

  findAllPeople() async {
    return await _pessoasRepository.findAllPeople();
  }
}

