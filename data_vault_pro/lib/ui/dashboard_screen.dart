import 'package:data_vault_pro/core/ad_manager.dart';
import 'package:data_vault_pro/services/file_service.dart';
import 'package:data_vault_pro/ui/data_view_screen.dart';
import 'package:data_vault_pro/ui/widgets/file_drop_area.dart';
import 'package:data_vault_pro/ui/widgets/file_list.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final FileService _fileService = FileService();

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      //final file = File(result.files.single.path!);
      //await _fileService.saveFile(file);
      setState(() {}); // Refresh file list
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InsightLocal Pro'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _pickFile,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FileDropArea(
              onFilesDropped: (files) {
                //for (var file in files) {
                //  await _fileService.saveFile(file);
                //}
                setState(() {}); // Refresh file list
              },
              child: FutureBuilder<List<dynamic>>(
                future: _fileService.getFiles(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  final files = snapshot.data ?? [];
                  return FileList(
                    files: files,
                    onFileTap: (file) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DataViewScreen(file: file),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          AdManager.adaptiveBanner(),
        ],
      ),
    );
  }
}
