import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../core/const/route_constants.dart';


class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(RouteConstants.homeModule);
    return MaterialApp.router(
      title: 'Flutter-FireStore',
      debugShowCheckedModeBanner: false,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}