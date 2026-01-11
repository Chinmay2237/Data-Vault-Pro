import 'package:flutter/material.dart';

class FileDropArea extends StatelessWidget {
  final Widget child;
  final Function(List<String>) onFilesDropped;

  const FileDropArea({
    super.key,
    required this.child,
    required this.onFilesDropped,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<List<String>>(
      builder: (context, candidateData, rejectedData) => child,
      onWillAccept: (data) => true,
      onAccept: (data) => onFilesDropped(data),
    );
  }
}
