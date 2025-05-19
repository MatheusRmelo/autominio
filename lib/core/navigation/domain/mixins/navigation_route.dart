import 'package:flutter/material.dart';
import '../models/route_model.dart';

mixin NavigationRoute {
  String get prefix;
  List<RouteModel> get routes;

  ({Map<String, dynamic> args, String path})? getPathAndArgs(
      String path, String route) {
    List<String> pathData =
        path.split("/").where((element) => element.isNotEmpty).toList();
    List<String> routeData =
        route.split("/").where((element) => element.isNotEmpty).toList();
    if (pathData.length == routeData.length) {
      String basePath = "";
      Map<String, dynamic> args = {};
      for (int index = 0; index < pathData.length; index++) {
        if (pathData[index] == routeData[index]) {
          basePath += "${pathData[index]}/";
        } else if (pathData[index].startsWith(":")) {
          args[pathData[index].replaceFirst(":", "")] = routeData[index];
          basePath += "${pathData[index]}/";
        }
      }

      return (args: args, path: basePath);
    }
    return null;
  }

  Widget? navigate(String route) {
    Widget? page;
    if (route.contains(prefix)) {
      int index = routes.indexWhere(
          (element) => getPathAndArgs("$prefix${element.path}", route) != null);
      if (index > -1) {
        var response = getPathAndArgs("$prefix${routes[index].path}", route);
        page = routes[index].child(response?.args);
      }
    }

    return page;
  }
}
