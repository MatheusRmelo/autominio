import 'package:flutter/material.dart';

import '../custom_dropdown_field.dart';

class DynamicForeignField<T> extends StatefulWidget {
  const DynamicForeignField({
    super.key,
    required this.getData,
    required this.label,
    this.value,
    required this.getIds,
    required this.onChanged,
  });
  final Future<List> Function() getData;
  final String label;
  final String? value;
  final List<CustomDropdownModel> Function(List data) getIds;
  final ValueChanged<String?> onChanged;
  @override
  State<DynamicForeignField<T>> createState() => _DynamicForeignFieldState<T>();
}

class _DynamicForeignFieldState<T> extends State<DynamicForeignField<T>> {
  List data = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    setState(() => _isLoading = true);
    var result = await widget.getData();
    List<CustomDropdownModel> ids = widget.getIds(result);

    if (mounted) {
      if ((widget.value ?? "").isEmpty && ids.isNotEmpty) {
        widget.onChanged(ids.first.id);
      }
      setState(() {
        data = result;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.label,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              height: 48,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('Carregando...'),
            ),
          ],
        ),
      );
    }
    return CustomDropdownField(
      label: widget.label,
      list: widget.getIds(data),
      value: widget.value,
      onChanged: widget.onChanged,
    );
  }
}
