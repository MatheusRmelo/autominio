import 'package:flutter/material.dart';

class DynamicCheckboxField extends StatelessWidget {
  final String label;
  final String? value;
  final bool hasError;
  final Color? labelColor;
  final Function(String? value) onChanged;

  const DynamicCheckboxField(
      {super.key,
      required this.label,
      required this.onChanged,
      this.value,
      this.labelColor,
      this.hasError = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      margin: const EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.bottomLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
              value: value == 'true',
              onChanged: (value) {
                if (value != null) onChanged(value.toString());
              }),
          Text(
            label,
            style: TextStyle(
                fontSize: 16,
                color: labelColor ?? Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
