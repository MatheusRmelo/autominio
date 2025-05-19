import 'package:flutter/material.dart';

class ListItemModel {
  String title;
  String? description;
  IconData? icon;

  ListItemModel({required this.title, this.description, this.icon});
}
