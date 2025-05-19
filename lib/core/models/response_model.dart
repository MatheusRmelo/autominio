class ResponseModel<T> {
  final bool ok;
  final T? result;
  final String description;
  final String? technicalDescription;
  final String? code;
  final List<ErrorFieldModel> errors;

  ResponseModel(
      {required this.ok,
      this.result,
      this.description = '',
      this.code = "",
      List<ErrorFieldModel>? errors,
      this.technicalDescription})
      : errors = errors ?? [];
}

class ErrorFieldModel {
  String key;
  List<String> errors;

  ErrorFieldModel({required this.key, required this.errors});

  ErrorFieldModel.fromJson(Map<String, dynamic> json)
      : key = json['key'],
        errors = (json['errors'] as List).map((e) => e.toString()).toList();
}
