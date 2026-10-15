import 'dart:io';

import 'package:test/test.dart';

import '../tool/public_operations.dart';

// Every route the SDK calls must be a documented public operation, with the
// same HTTP method. The documented operations are vendored in
// test/fixtures/public_operations.txt so this also runs outside the Vedika
// monorepo; inside it, the fixture must match web/vedika-public/openapi.json.
void main() {
  final fixture = File(fixturePath)
      .readAsLinesSync()
      .where((l) => l.trim().isNotEmpty)
      .toSet();
  final spec = File(monorepoSpecPath);

  test('fixture matches the published openapi.json', () {
    final expected = publicOperations(spec.readAsStringSync());
    expect(fixture, equals(expected.toSet()),
        reason: 'run `dart run tool/public_operations.dart` to refresh it');
  },
      skip: spec.existsSync()
          ? false
          : 'openapi.json is only present in the Vedika monorepo');

  final calls = sdkCalls(Directory('lib'));

  test('the scan finds the SDK call sites', () {
    expect(calls.length, greaterThan(300));
    expect(calls.where((c) => c.method == 'GET'), isNotEmpty);
    expect(calls.where((c) => c.path.contains('*')), isNotEmpty);
  });

  test('every SDK call is a documented operation', () {
    final missing = [
      for (final c in calls)
        if (!isDocumented(c, fixture)) '${c.method} ${c.path}  (${c.where})'
    ];
    expect(missing, isEmpty);
  });

  test('a route the API does not document is caught', () {
    const ghost = SdkCall('POST', '/v2/astrology/saturn-transit', 'x');
    const wrongMethod = SdkCall('POST', '/v2/astrology/choghadiya', 'x');
    const dynamicOk = SdkCall('GET', '/v2/astrology/horoscope/*', 'x');
    expect(isDocumented(ghost, fixture), isFalse);
    expect(isDocumented(wrongMethod, fixture), isFalse);
    expect(isDocumented(dynamicOk, fixture), isTrue);
  });

  test('call sites must pass the path as one string literal', () {
    expect(() => sdkCallsIn("_client.post('/v2/a/' + x, {})", 'f.dart'),
        throwsA(isA<FormatException>()));
    expect(
        sdkCallsIn(r"_client.get('/v2/a/${f(b['c'])}/d')", 'f.dart')
            .single
            .path,
        '/v2/a/*/d');
    expect(sdkCallsIn("_client\n      .get('/v2/b')", 'f.dart').single.path,
        '/v2/b');
  });
}
