import 'package:data_vault_pro/models/file_metadata.dart';
import 'package:flutter/material.dart';

class FileList extends StatelessWidget {
  final List<dynamic> files;
  final Function(dynamic) onFileTap;

  const FileList({super.key, required this.files, required this.onFileTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: files.length,
      itemBuilder: (context, index) {
        final file = files[index];
        return ListTile(
          title: Text(file.name),
          subtitle: Text('${file.size} bytes'),
          onTap: () => onFileTap(file),
        );
      },
    );
  }
}
