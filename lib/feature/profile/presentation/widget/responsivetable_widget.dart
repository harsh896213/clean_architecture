import 'package:flutter/material.dart';
import 'package:pva/core/extension/context_ext.dart';

class ResponsiveTable extends StatelessWidget {
  final List<String> headers;
  final List<List<String>> rows;
  final bool isScrollable;

  const ResponsiveTable({
    Key? key,
    required this.headers,
    required this.rows,
    this.isScrollable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.isMobile && isScrollable) {
      return _buildScrollableTable();
    } else {
      return _buildNormalTable();
    }
  }

  Widget _buildNormalTable() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Table(
          border: TableBorder.all(
            color: Colors.grey.shade200,
            width: 1,
          ),
          columnWidths: _getColumnWidths(),
          children: [
            // Header row
            TableRow(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
              ),
              children: headers.map((header) =>
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        header,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
              ).toList(),
            ),
            // Data rows
            ...rows.map((row) =>
                TableRow(
                  children: row.map((cell) =>
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(cell),
                        ),
                      )
                  ).toList(),
                )
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScrollableTable() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 700,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Table(
              border: TableBorder.all(
                color: Colors.grey.shade200,
                width: 1,
              ),
              columnWidths: _getColumnWidths(),
              children: [
                // Header row
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                  ),
                  children: headers.map((header) =>
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            header,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                  ).toList(),
                ),
                // Data rows
                ...rows.map((row) =>
                    TableRow(
                      children: row.map((cell) =>
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(cell),
                            ),
                          )
                      ).toList(),
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Map<int, TableColumnWidth> _getColumnWidths() {
    Map<int, TableColumnWidth> widths = {};

    // Determine appropriate column widths based on the headers structure
    if (headers.length >= 7) {
      // For 7-column tables (Medication, Activity, Task)
      widths = {
        0: const FlexColumnWidth(3),  // Name
        1: const FlexColumnWidth(2),  // Start Date
        2: const FlexColumnWidth(2),  // Duration
        3: const FlexColumnWidth(2),  // Morning
        4: const FlexColumnWidth(2),  // Afternoon
        5: const FlexColumnWidth(2),  // Evening
        6: const FlexColumnWidth(1),  // Night
      };
    } else if (headers.length == 4) {
      // For 4-column tables (Survey)
      widths = {
        0: const FlexColumnWidth(4),  // Name
        1: const FlexColumnWidth(2),  // Start Date
        2: const FlexColumnWidth(2),  // Duration
        3: const FlexColumnWidth(2),  // Frequency
      };
    } else {
      // Generic fallback for any other table structure
      for (int i = 0; i < headers.length; i++) {
        widths[i] = const FlexColumnWidth(1);
      }
    }
    return widths;
  }
}

// Reusable schedule table for Medication, Activity, and Task
class ScheduleTable extends StatelessWidget {
  final String type; // "medication", "activity", or "task"
  final List<Map<String, String>> items;

  const ScheduleTable({
    Key? key,
    required this.type,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Common headers for schedule tables
    const headers = [
      'Name',
      'Start Date',
      'Duration',
      'Morning',
      'Afternoon',
      'Evening',
      'Night',
    ];

    // Convert item maps to rows
    final rows = items.map((item) => [
      item['name'] ?? '',
      item['startDate'] ?? '',
      item['duration'] ?? '',
      item['morning'] ?? '',
      item['afternoon'] ?? '',
      item['evening'] ?? '-',
      item['night'] ?? '-',
    ]).toList();

    return ResponsiveTable(
      headers: headers,
      rows: rows,
      isScrollable: true,
    );
  }
}

// Survey Table
class SurveyTable extends StatelessWidget {
  final List<Map<String, String>> items;

  const SurveyTable({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const headers = [
      'Name',
      'Start Date',
      'Duration',
      'Frequency',
    ];

    final rows = items.map((item) => [
      item['name'] ?? '',
      item['startDate'] ?? '',
      item['duration'] ?? '',
      item['frequency'] ?? '',
    ]).toList();

    return ResponsiveTable(
      headers: headers,
      rows: rows,
      isScrollable: false,
    );
  }
}