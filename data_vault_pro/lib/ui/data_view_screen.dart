import 'package:data_vault_pro/models/file_metadata.dart';
import 'package:data_vault_pro/services/data_mapper.dart';
import 'package:flutter/material.dart';

class DataViewScreen extends StatelessWidget {
  final FileMetadata file;

  const DataViewScreen({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(file.name),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final data = snapshot.data ?? [];
          return DataMapper.buildVisualization(data);
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _loadData() async {
    // This is a placeholder. In a real app, you would read the file
    // and parse it based on its type (CSV, Excel, etc.)
    await Future.delayed(const Duration(seconds: 1));
    return [
      {'col1': 1, 'col2': 'A'},
      {'col1': 2, 'col2': 'B'},
      {'col1': 3, 'col2': 'C'},
    ];
  }
}
