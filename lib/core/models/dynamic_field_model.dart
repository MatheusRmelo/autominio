import 'package:flutter/material.dart';

import '../presentation/custom_dropdown_field.dart';

class DynamicFieldModel {
  String code;

  String label;
  String? placeholder;
  FieldType type;
  String? value;
  List<CustomDropdownModel>? list;
  ValueChanged<DynamicFieldModel>? onChange;
  final Future<List> Function()? getData;
  final List<CustomDropdownModel> Function(List data)? getIds;

  DynamicFieldModel(
      {required this.label,
      required this.code,
      this.placeholder,
      this.type = FieldType.text,
      this.value,
      this.getData,
      this.getIds,
      this.list,
      this.onChange});
}

enum FieldType {
  select,
  text,
  real,
  day,
  foreign,
  boolean,
  dropdown,
  textarea,
  image,
  empty,
  password,
  number
}
