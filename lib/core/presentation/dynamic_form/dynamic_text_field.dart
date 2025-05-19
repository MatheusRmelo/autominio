import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../custom_text_field.dart';

class DynamicTextField extends StatefulWidget {
  const DynamicTextField({
    super.key,
    required this.label,
    this.placeholder,
    this.value,
    this.formatters,
    this.keyboardType = TextInputType.text,
    required this.onChanged,
    this.isPassword = false,
  });

  final String label;
  final String? placeholder;
  final String? value;
  final ValueChanged<String?> onChanged;
  final List<TextInputFormatter>? formatters;
  final TextInputType keyboardType;
  final bool isPassword;

  @override
  State<DynamicTextField> createState() => _DynamicTextFieldState();
}

class _DynamicTextFieldState extends State<DynamicTextField> {
  final TextEditingController _textInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textInputController.text = widget.value ?? "";
    _textInputController.addListener(() {
      widget.onChanged(_textInputController.text);
    });
  }

  @override
  void dispose() {
    _textInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: _textInputController,
      placeholder: widget.placeholder,
      label: widget.label,
      formatters: widget.formatters,
      keyboardType: widget.keyboardType,
      isPassword: widget.isPassword,
    );
  }
}
