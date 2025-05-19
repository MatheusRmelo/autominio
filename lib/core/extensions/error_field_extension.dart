import '../models/response_model.dart';

extension ErrorFieldExtension on List<ErrorFieldModel> {
  String? getErrorWithCode(String code) {
    int index = indexWhere((element) => element.key == code);
    if (index == -1) return null;
    return this[index].errors.isNotEmpty ? this[index].errors.first : null;
  }
}
