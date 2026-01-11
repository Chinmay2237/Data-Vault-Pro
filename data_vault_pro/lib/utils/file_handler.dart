import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:data_vault_pro/models/file_metadata.dart';
import 'package:data_vault_pro/services/csv_parser.dart';
import 'package:data_vault_pro/services/excel_parser.dart';
import 'package:data_vault_pro/ui/data_view_screen.dart';

class FileHandler {
  static Future<void> pickAndProcessFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    final path = result.files.single.path!;
    final file = File(path);
    final name = file.path.split('/').last;
    final size = await file.length();
    final type = name.split('.').last;

    final metadata = FileMetadata(
      path: path,
      name: name,
      size: size,
      type: type,
      createdAt: DateTime.now(),
    );

    List<Map<String, dynamic>> data;
    if (type == 'csv') {
      data = await parseCsvInBackground(path);
    } else if (type == 'xlsx') {
      data = await parseExcelInBackground(path);
    } else {
      // Unsupported file type
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DataViewScreen(data: data, title: name),
      ),
    );
  }
}
