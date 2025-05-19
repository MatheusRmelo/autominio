import 'package:flutter/material.dart';

class RouteModel {
  String path;
  Widget Function(Map<String, dynamic>? args) child;

  RouteModel({required this.path, required this.child});
}
