import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:excel/excel.dart';

Future<List<Map<String, dynamic>>> parseExcelInBackground(String path) async {
  return await compute(_parseExcelIsolate, path);
}

List<Map<String, dynamic>> _parseExcelIsolate(String path) {
  final file = File(path);
  final bytes = file.readAsBytesSync();
  final excel = Excel.decodeBytes(bytes);

  final table = excel.tables[excel.tables.keys.first]!;
  final rows = table.rows;

  final header = rows.first.map((cell) => cell?.value.toString() ?? '').toList();

  final data = <Map<String, dynamic>>[];
  for (var i = 1; i < rows.length; i++) {
    final row = rows[i];
    final rowData = <String, dynamic>{};
    for (var j = 0; j < header.length; j++) {
      rowData[header[j]] = row[j]?.value;
    }
    data.add(rowData);
  }

  return data;
}
