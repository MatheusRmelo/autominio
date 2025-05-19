import 'dart:io';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';

import '../custom_button.dart';
import '../custom_file_field.dart';

class DynamicFileField extends StatefulWidget {
  const DynamicFileField({
    super.key,
    required this.label,
    this.placeholder = "Selecione a imagem",
    this.value,
    required this.onChanged,
  });

  final String label;
  final String placeholder;
  final String? value;
  final ValueChanged<String?> onChanged;

  @override
  State<DynamicFileField> createState() => _DynamicFileFieldState();
}

class _DynamicFileFieldState extends State<DynamicFileField> {
  XFile? _file;
  String? _url;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    if (widget.value != null) {
      setState(() {
        if (widget.value!.startsWith('http')) {
          _url = widget.value!;
        } else {
          _file = XFile(widget.value!);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        if (_file != null)
          Row(
            children: [
              Image.file(
                File(_file!.path),
                width: 120,
                height: 120,
                fit: BoxFit.fill,
              ),
              const SizedBox(width: 8),
              CustomButton(
                  width: 120,
                  title: 'Limpar',
                  onPressed: () {
                    setState(() {
                      _file = null;
                    });
                    widget.onChanged("");
                  })
            ],
          )
        else if (_url != null)
          Row(
            children: [
              Image.network(
                _url!,
                width: 120,
                height: 120,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Text('Falha ao carregar imagem'),
                ),
              ),
              const SizedBox(width: 8),
              CustomButton(
                  width: 120,
                  title: 'Limpar',
                  onPressed: () {
                    setState(() {
                      _file = null;
                      _url = null;
                    });
                    widget.onChanged("");
                  })
            ],
          ),
        const SizedBox(
          height: 8,
        ),
        if (_file == null)
          CustomFileField(
            file: _file,
            isPDF: false,
            title: widget.placeholder,
            onChanged: (value) async {
              setState(() {
                _file = value;
              });
              if (_file != null) {
                widget.onChanged(_file!.path);
              }
            },
          ),
      ],
    );
  }
}
