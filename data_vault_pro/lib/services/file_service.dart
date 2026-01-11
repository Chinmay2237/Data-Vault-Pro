import 'dart:io';

import 'package:data_vault_pro/models/file_metadata.dart';
import 'package:path_provider/path_provider.dart';

class FileService {
  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> saveFile(File file) async {
    final path = await localPath;
    final newFile = File('$path/${file.path.split('/').last}');
    return file.copy(newFile.path);
  }

  Future<List<FileMetadata>> getFiles() async {
    final path = await localPath;
    final directory = Directory(path);
    final files = directory.listSync();

    return files.map((file) {
      final stat = file.statSync();
      return FileMetadata(
        path: file.path,
        name: file.path.split('/').last,
        size: stat.size,
        type: file.path.split('.').last,
        createdAt: stat.changed,
      );
    }).toList();
  }
}
