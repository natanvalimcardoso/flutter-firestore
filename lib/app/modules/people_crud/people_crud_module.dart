import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/people_list.dart';


class PeopleCrudModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(
      Modular.initialRoute,
      child: (_, __) =>  const ChooseTheCardPage(),
    )
  ];
}