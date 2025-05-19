import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

class CustomFileField extends StatefulWidget {
  const CustomFileField({
    super.key,
    this.title = 'Upload or drop image',
    this.file,
    this.isPDF = true,
    this.onChanged,
    this.onChangedBytes,
  });

  final String title;
  final XFile? file;
  final bool isPDF;
  final ValueChanged<XFile?>? onChanged;
  final ValueChanged<List<Uint8List>?>? onChangedBytes;

  @override
  State<CustomFileField> createState() => _CustomFileFieldState();
}

class _CustomFileFieldState extends State<CustomFileField> {
  late DropzoneViewController controller;

  void getFilePdf() async {
    XFile? file = await openFile(acceptedTypeGroups: [
      const XTypeGroup(
        label: 'PDFs',
        extensions: <String>['pdf'],
      )
    ]);
    if (file != null && widget.onChanged != null) {
      widget.onChanged!(file);
    }
  }

  void getFileImage() async {
    XFile? file = await openFile(acceptedTypeGroups: [
      const XTypeGroup(
        label: 'JPEGs',
        extensions: <String>['jpg', 'jpeg'],
      ),
      const XTypeGroup(
        label: 'PNGs',
        extensions: <String>['png'],
      )
    ]);
    if (file != null) {
      widget.onChanged!(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.isPDF) {
          getFilePdf();
        } else {
          getFileImage();
        }
      },
      child: SizedBox(
        child: Stack(
          children: [
            if (!Platform.isWindows)
              DropzoneView(
                onCreated: (controller) {
                  this.controller = controller;
                },
                onDropFiles: (value) async {
                  if (value == null) return;
                  List<Uint8List> allBytes = [];
                  for (var element in value) {
                    var bytes = await controller.getFileData(element);
                    allBytes.add(bytes);
                  }
                  if (widget.onChangedBytes != null) {
                    widget.onChangedBytes!(allBytes);
                  }
                },
              ),
            DottedBorder(
              color: Theme.of(context).primaryColor,
              strokeWidth: 2,
              borderType: BorderType.RRect,
              radius: const Radius.circular(10),
              child: Container(
                color: const Color(0xFFF1F5FF),
                padding: const EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.upload_file,
                        size: 24,
                        color: Color(0xFF0036CC),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        widget.title,
                        style: const TextStyle(
                            fontSize: 16, color: Color(0xFF0036CC)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
