// The package uploads its library, tests and docs, so every line is customer
// facing. Internal tracker ids, pull-request numbers and deployment-status
// notes mean nothing to a customer and go stale.
import 'dart:io';

import 'package:test/test.dart';

final internalReference = RegExp(
  r'(?<![A-Za-z0-9_])(?:[MRP]-\d{3}|SDK-\d{1,3}|INC-\d{8}(?:-\d+)?)(?![0-9])'
  r'|\bPR #\d+|not\s+yet\s+deployed|docs[/]ops[/]',
  caseSensitive: false,
);

void main() {
  test('shipped files carry no internal references', () {
    final files = <File>[
      File('README.md'),
      File('CHANGELOG.md'),
      File('pubspec.yaml'),
      for (final dir in ['lib', 'test'])
        ...Directory(dir)
            .listSync(recursive: true)
            .whereType<File>()
            .where((f) => f.path.endsWith('.dart')),
    ];
    final offenders = <String>[];
    for (final file in files) {
      final lines = file.readAsLinesSync();
      for (var i = 0; i < lines.length; i++) {
        if (internalReference.hasMatch(lines[i])) {
          offenders.add('${file.path}:${i + 1}: ${lines[i].trim()}');
        }
      }
    }
    expect(offenders, isEmpty);

    // Known-positive control: the pattern fires on the shape that shipped.
    expect(internalReference.hasMatch('routing policy (R-' '004).'), isTrue);
    expect(internalReference.hasMatch('SHA-256, UTF-8 and ISO-8601'), isFalse);
  });
}
