import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../models/dynamic_field_model.dart';
import '../../utils/formatter.dart';
import 'dynamic_calendar_field.dart';
import 'dynamic_checkbox_field.dart';
import 'dynamic_dropdown_field.dart';
import 'dynamic_file_field.dart';
import 'dynamic_foreign_field.dart';
import 'dynamic_text_field.dart';
import 'dynamic_textarea_field.dart';

class DynamicFieldWidget extends StatefulWidget {
  const DynamicFieldWidget({
    super.key,
    required this.field,
    required this.onChange,
  });

  final DynamicFieldModel field;
  final ValueChanged<DynamicFieldModel?> onChange;
  @override
  State<DynamicFieldWidget> createState() => _DynamicFieldWidgetState();
}

class _DynamicFieldWidgetState extends State<DynamicFieldWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.field.type == FieldType.text) {
      return DynamicTextField(
        value: widget.field.value,
        placeholder: widget.field.placeholder,
        label: widget.field.label,
        onChanged: (value) {
          var field = widget.field;
          field.value = value;
          widget.onChange(field);
        },
      );
    }
    if (widget.field.type == FieldType.password) {
      return DynamicTextField(
        value: widget.field.value,
        placeholder: widget.field.placeholder,
        label: widget.field.label,
        isPassword: true,
        onChanged: (value) {
          var field = widget.field;
          field.value = value;
          widget.onChange(field);
        },
      );
    }
    if (widget.field.type == FieldType.real) {
      return DynamicTextField(
        value: widget.field.value,
        placeholder: widget.field.placeholder,
        label: widget.field.label,
        formatters: [
          FilteringTextInputFormatter.digitsOnly,
          Formatter.getRealInputFormatter(),
        ],
        keyboardType: TextInputType.number,
        onChanged: (value) {
          var field = widget.field;
          field.value = value;
          widget.onChange(field);
        },
      );
    }
    if (widget.field.type == FieldType.number) {
      return DynamicTextField(
        value: widget.field.value,
        placeholder: widget.field.placeholder,
        label: widget.field.label,
        formatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        keyboardType: TextInputType.number,
        onChanged: (value) {
          var field = widget.field;
          field.value = value;
          widget.onChange(field);
        },
      );
    }
    if (widget.field.type == FieldType.day) {
      return DynamicCalendarField(
          label: widget.field.label,
          activeDate: widget.field.value == null
              ? DateTime.now()
              : DateTime.parse(widget.field.value!),
          onChanged: (value) {
            if (value != null) {
              var field = widget.field;
              field.value = DateFormat('yyyy-MM-dd').format(value);
              widget.onChange(field);
            }
          });
    }
    if (widget.field.type == FieldType.foreign) {
      return DynamicForeignField(
        value: widget.field.value,
        label: widget.field.label,
        getData: widget.field.getData ?? () async => [],
        getIds: widget.field.getIds ?? (v) => [],
        onChanged: (value) {
          var field = widget.field;
          field.value = value;
          widget.onChange(field);
        },
      );
    }
    if (widget.field.type == FieldType.boolean) {
      return DynamicCheckboxField(
          label: widget.field.label,
          value: widget.field.value,
          onChanged: (value) {
            var field = widget.field;
            field.value = value;
            widget.onChange(field);
          });
    }

    if (widget.field.type == FieldType.dropdown) {
      return DynamicDropdownField(
          label: widget.field.label,
          value: widget.field.value,
          list: widget.field.list ?? [],
          onChanged: (value) {
            var field = widget.field;
            field.value = value;
            widget.onChange(field);
          });
    }
    if (widget.field.type == FieldType.textarea) {
      return DynamicTextareaField(
        value: widget.field.value,
        placeholder: widget.field.placeholder,
        label: widget.field.label,
        onChanged: (value) {
          var field = widget.field;
          field.value = value;
          widget.onChange(field);
        },
      );
    }
    if (widget.field.type == FieldType.image) {
      return DynamicFileField(
        value: widget.field.value,
        label: widget.field.label,
        placeholder: widget.field.placeholder ?? '',
        onChanged: (value) {
          var field = widget.field;
          field.value = value;
          widget.onChange(field);
        },
      );
    }
    if (widget.field.type == FieldType.empty) {
      return const SizedBox.shrink();
    }
    throw Exception("Dynamic Field Type choose is not available yet");
  }
}
