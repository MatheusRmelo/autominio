import 'package:flutter/material.dart';

import '../custom_textarea_field.dart';

class DynamicTextareaField extends StatefulWidget {
  const DynamicTextareaField({
    super.key,
    required this.label,
    this.placeholder,
    this.value,
    required this.onChanged,
  });

  final String label;
  final String? placeholder;
  final String? value;
  final ValueChanged<String?> onChanged;

  @override
  State<DynamicTextareaField> createState() => _DynamicTextareaFieldState();
}

class _DynamicTextareaFieldState extends State<DynamicTextareaField> {
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
    return CustomTextareaField(
      controller: _textInputController,
      placeholder: widget.placeholder ?? '',
      label: widget.label,
    );
  }
}
