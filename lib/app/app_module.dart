import 'package:flutter_modular/flutter_modular.dart';

import '../core/const/route_constants.dart';
import 'modules/home/home_module.dart';
import 'modules/people_crud/people_crud_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<Module> get imports => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          RouteConstants.homeModule,
          module: HomeModule(),
        ),
        ModuleRoute(
          RouteConstants.peopleCrudModule,
          module: PeopleCrudModule(),
        ),
      ];
}
