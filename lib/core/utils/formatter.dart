import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';

class Formatter {
  static String formatReal(double value) => UtilBrasilFields.obterReal(value);
  static double getReal(String value) =>
      UtilBrasilFields.converterMoedaParaDouble(value);
  static TextInputFormatter getRealInputFormatter() => CentavosInputFormatter(
        moeda: true,
      );
}
