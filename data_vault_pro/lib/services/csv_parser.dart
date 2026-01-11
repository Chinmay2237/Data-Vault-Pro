import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:csv/csv.dart';

Future<List<Map<String, dynamic>>> parseCsvInBackground(String path) async {
  return await compute(_parseCsvIsolate, path);
}

List<Map<String, dynamic>> _parseCsvIsolate(String path) {
  final file = File(path);
  final content = file.readAsStringSync();

  final List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(content);

  final header = rowsAsListOfValues.first.map((c) => c.toString()).toList();
  final data = <Map<String, dynamic>>[];

  for (var i = 1; i < rowsAsListOfValues.length; i++) {
    final row = rowsAsListOfValues[i];
    final rowData = <String, dynamic>{};
    for (var j = 0; j < header.length; j++) {
      rowData[header[j]] = row[j];
    }
    data.add(rowData);
  }

  return data;
}
