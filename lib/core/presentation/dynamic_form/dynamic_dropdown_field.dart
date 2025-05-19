import 'package:flutter/material.dart';

import '../custom_dropdown_field.dart';

class DynamicDropdownField extends StatefulWidget {
  const DynamicDropdownField({
    super.key,
    required this.label,
    this.value,
    required this.list,
    required this.onChanged,
  });

  final String label;
  final List<CustomDropdownModel> list;
  final String? value;
  final ValueChanged<String?> onChanged;

  @override
  State<DynamicDropdownField> createState() => _DynamicDropdownFieldState();
}

class _DynamicDropdownFieldState extends State<DynamicDropdownField> {
  @override
  Widget build(BuildContext context) {
    return CustomDropdownField(
      list: widget.list,
      onChanged: widget.onChanged,
      label: widget.label,
      value: widget.value,
    );
  }
}
