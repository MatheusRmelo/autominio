import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import '../../extensions/context_extension.dart';

import '../../models/dynamic_field_model.dart';
import 'dynamic_field_widget.dart';

class DynamicFormWidget extends StatefulWidget {
  const DynamicFormWidget(
      {super.key, this.name, required this.fields, this.onChangedField});
  final List<DynamicFieldModel> fields;
  final String? name;
  final void Function(int index, DynamicFieldModel value)? onChangedField;

  @override
  State<DynamicFormWidget> createState() => _DynamicFormWidgetState();
}

class _DynamicFormWidgetState extends State<DynamicFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (widget.name != null)
        Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Text(widget.name!)),
      Wrap(
        children: widget.fields
            .mapIndexed((index, element) => Container(
                  width: context.isMobile ? null : 500,
                  margin: const EdgeInsets.only(right: 16),
                  child: DynamicFieldWidget(
                    field: widget.fields[index],
                    onChange: (value) {
                      if (value != null && widget.onChangedField != null) {
                        widget.onChangedField!(index, value);
                      }
                    },
                  ),
                ))
            .toList(),
      ),
    ]);
  }
}
