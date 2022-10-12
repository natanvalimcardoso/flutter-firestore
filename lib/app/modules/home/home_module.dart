import 'package:flutter_firestore/app/modules/home/presentation/pages/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';


class HomeModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(
      Modular.initialRoute,
      child: (_, __) =>  HomePage(),
    )
  ];
}