import 'package:flutter_firestore/app/modules/people_crud/model/pessoa_model.dart';
import 'package:flutter_firestore/app/modules/people_crud/repositories/pessoas_repositories.dart';

class ControllerPessoas {
  final _pessoasRepository = PessoasRepositories();

  findAll() async {
    final pessoas = await _pessoasRepository.readFirebase();

    return pessoas;
  }
}

main() {
  final _controllerPessoas = ControllerPessoas();
  for (var element in _controllerPessoas.findAll()) {
    print(element);
  }
}
