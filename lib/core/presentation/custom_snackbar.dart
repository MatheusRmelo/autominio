import 'package:flutter/material.dart';

class ErrorSnackbar extends SnackBar {
  ErrorSnackbar({
    super.key,
    required BuildContext context,
    required super.content,
  }) : super(
          backgroundColor: Theme.of(context).colorScheme.error,
          action: SnackBarAction(
            label: 'FECHAR',
            textColor: Colors.white,
            onPressed: () {},
          ),
        );
}

class SuccessSnackbar extends SnackBar {
  SuccessSnackbar({
    super.key,
    required BuildContext context,
    required super.content,
  }) : super(
          backgroundColor: Colors.green,
          action: SnackBarAction(
            label: 'FECHAR',
            textColor: Colors.white,
            onPressed: () {},
          ),
        );
}
