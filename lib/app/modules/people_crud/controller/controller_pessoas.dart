import 'package:flutter_firestore/app/modules/people_crud/repositories/pessoas_repositories.dart';

class ControllerPessoas {
  final _pessoasRepository = PessoasRepositories();

  findAll() async {
    final pessoas = await _pessoasRepository.readFirebase();
    return pessoas;
  }
}

