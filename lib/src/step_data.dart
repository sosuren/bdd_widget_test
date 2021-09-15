
class StepTableHeader {

  StepTableHeader({required this.names});

  final List<String> names;

  @override
  String toString() => names.join(', ');

  String get dartContent => """
  StepTableHeader(
      names: [${names.map((n) => '\'$n\'').join(',')}]
    )
  """;
}

class StepTableRow {

  StepTableRow({required this.values});

  final List<String?> values;

  @override
  String toString() => values.join(', ');

  String get dartContent => """
StepTableRow(
      values: [${values.map((v) => '\'$v\'').join(',')}]
    )
  """;
}

class StepTable {

  StepTable({required this.identifier, required this.header, required this.rows}) {

    if (header.names.isEmpty) {
      throw Exception('Input headers should not be empty');
    }

    if (rows.isEmpty) {
      throw Exception('Input data row should not be empty');
    }

    final totalItems = rows.fold<int>(0, (previousValue, element) => previousValue + element.values.length);

    // all rows do not have equal number of items
    if (totalItems != rows.first.values.length * rows.length) {
      throw Exception('Inconsistent data row length');
    }
  }

  final String identifier;
  final StepTableHeader header;
  final List<StepTableRow> rows;

  StepTable copyWithRow(int atIndex) {

    final selectedRow = rows[atIndex];

    return StepTable(
      identifier: identifier,
      header: header,
      rows: [selectedRow],
    );
  }

  @override
  String toString() {

    final stringBuffer = StringBuffer();

    stringBuffer.write('Table: $identifier');

    stringBuffer.write('\n\tHeader: $header');

    for (final row in rows) {
      stringBuffer.write('\n\tRow: $row');
    }

    return stringBuffer.toString();
  }

  String get dartContent => """
  StepTable(
    identifier: '$identifier',
    header: ${header.dartContent},
    rows: [
      ${rows.map((r) => r.dartContent).join(',\n')}
    ]
  )
  """;
}

class ScenarioTables {

  ScenarioTables({required this.identifier, required this.tables});

  final String identifier;
  final List<StepTable> tables;

  String get dartContent => """
  '$identifier': {
    ${tables.map((t) => '\'${t.identifier}\': ${t.dartContent}').join(',\n')}
  },
  """;
}
