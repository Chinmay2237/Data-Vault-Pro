import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DataMapper {
  static Widget buildVisualization(List<Map<String, dynamic>> data) {
    if (data.isEmpty) {
      return const Center(child: Text('No data to visualize.'));
    }

    // For simplicity, we'll check the first column to determine the type.
    final firstColumnName = data.first.keys.first;
    final firstColumnValues = data.map((row) => row[firstColumnName]).toList();

    if (isNumericColumn(firstColumnValues)) {
      return LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: data
                  .asMap()
                  .entries
                  .map((e) => FlSpot(e.key.toDouble(), e.value[firstColumnName]))
                  .toList(),
            )
          ],
        ),
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: data.first.keys.map((key) => DataColumn(label: Text(key))).toList(),
          rows: data
              .map(
                (row) => DataRow(
                  cells: row.values.map((value) => DataCell(Text(value.toString()))).toList(),
                ),
              )
              .toList(),
        ),
      );
    }
  }

  static bool isNumericColumn(List values) {
    return values.every((v) => v is num || double.tryParse(v.toString()) != null);
  }
}
