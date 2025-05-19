import 'dart:convert';
import 'dart:io';

import '../models/dynamic_field_model.dart';
import '../utils/formatter.dart';

extension ListDynamicFieldExtension on List<DynamicFieldModel> {
  List<DynamicFieldModel> fromJson(Map<String, dynamic> json) {
    List<DynamicFieldModel> result = this;
    for (int index = 0; index < result.length; index++) {
      result[index].value = result[index].type == FieldType.real &&
              json[result[index].code] is double
          ? Formatter.formatReal(json[result[index].code] as double)
          : json[result[index].code].toString();
    }

    return result;
  }

  Future<Map<String, String>> toJson() async {
    Map<String, String> result = {};

    for (var element in this) {
      String value = element.value ?? "";
      if (element.type == FieldType.image && !value.startsWith("http")) {
        List<int> bytes = await File(value).readAsBytes();
        value = base64Encode(bytes);
      }
      result[element.code] = value;
    }
    return result;
  }

  List<DynamicFieldModel> clearFields() {
    List<DynamicFieldModel> result = this;
    for (int index = 0; index < result.length; index++) {
      result[index].value = "";
    }

    return result;
  }
}
