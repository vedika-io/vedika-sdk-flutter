import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:vedika_sdk/vedika_sdk.dart';

// Actual keyless Rust HTTP recordings from our synthetic CAD fixtures.
// The recordings live in the monorepo only; a standalone checkout skips these tests.
final _demosFile = File('../../web/vedika-public/js/catalog/vastu-sandbox-demos.json');
final String? _skip = _demosFile.existsSync()
    ? null
    : 'monorepo fixture web/vedika-public/js/catalog/vastu-sandbox-demos.json not present';
Map<String, dynamic> get demos =>
    (jsonDecode(_demosFile.readAsStringSync()) as Map<String, dynamic>)['demos']
        as Map<String, dynamic>;

http.Response fixture(String op) => http.Response(
    jsonEncode(demos['vastu__plan_${op.replaceAll('-', '_')}']), 200,
    headers: {'content-type': 'application/json'});

void main() {
  test('DXF request preserves budget, unit/layer overrides and retry key', () async {
    final seen = <http.Request>[];
    final client = VedikaClient(apiKey: 'cad-test', httpClient: MockClient((r) async {
      seen.add(r);
      return fixture('import-dxf');
    }));
    const request = VastuPlanImportDxfRequest(dxf: 'DXF contents',
        fileName: 'rooms.dxf', contentType: 'application/dxf', trueNorthDeg: 30,
        unitsOverride: 4, layerRoles: {'A-SPACE': VastuCadLayerRole.room},
        maxChargeUsd: '0.10');
    try {
      final result = await client.cad.importDxf(request, idempotencyKey: 'cad:one');
      await client.cad.importDxf(request, idempotencyKey: 'cad:one');
      expect(seen.map((r) => r.headers['Idempotency-Key']), ['cad:one', 'cad:one']);
      expect(seen.first.url.path, '/v2/astrology/vastu/plan/import-dxf');
      expect(seen.first.method, 'POST');
      expect(seen.first.followRedirects, isFalse);
      expect(seen.first.headers['Authorization'], 'Bearer cad-test');
      expect(jsonDecode(seen.first.body), {
        'dxf': 'DXF contents', 'fileName': 'rooms.dxf',
        'contentType': 'application/dxf', 'trueNorthDeg': 30,
        'unitsOverride': 4, 'layerRoles': {'A-SPACE': 'room'}, 'maxChargeUsd': '0.10'
      });
      expect(result.success, isTrue);
      expect(result.billing!.charged, 0); // sandbox fixture, not a paid receipt
      expect(result.meta!.engine, 'vedika-intelligence');
      final data = result.data!;
      expect(data.plan.rooms.map((r) => r.name), ['Kitchen', 'Study', 'Pooja']);
      expect(data.plan.rooms.first.id, '35');
      expect(data.plan.rooms.first.area, closeTo(12, 1e-8));
      expect(data.plan.rooms.first.polygon.first[1], isA<double>());
      expect(data.plan.trueNorthDeg, 30);
      expect(data.plan.cadMetadata!['unitsCode'], 4);
      expect(data.plan.openings!.doors!.single.width, closeTo(0.9, 1e-8));
      expect(data.mappingReport.any((m) => m.handle == '35'), isTrue);
      expect(data.mappingReport.first.stepId, isNull);
    } finally { client.dispose(); }
  }, skip: _skip);

  test('IFC response retains both storeys, GlobalIds and rotated north', () async {
    late http.Request seen;
    final client = VedikaClient(apiKey: 'cad-test', httpClient: MockClient((r) async {
      seen = r;
      return fixture('import-ifc');
    }));
    try {
      final result = await client.cad.importIfc(
        const VastuPlanImportIfcRequest(ifc: 'STEP', maxChargeUsd: '0.01'),
        idempotencyKey: 'cad:ifc');
      expect(seen.url.path, '/v2/astrology/vastu/plan/import-ifc');
      expect(jsonDecode(seen.body), {'ifc': 'STEP', 'maxChargeUsd': '0.01'});
      final data = result.data!;
      expect(data.schema, 'IFC4');
      expect(data.storeys.length, 2);
      expect(data.trueNorthDeg, closeTo(30, 1e-8));
      expect(data.storeys.first.id, r'1p$CTDhB9UXfwDeNU7yv_V');
      expect(data.storeys.first.plan.rooms.first.id, '3JPSwLngDQVOsEMPdN4lPn');
      expect(data.storeys.first.plan.rooms.first.source!['longName'], 'Kitchen');
      expect(data.storeys.first.plan.openings!.doors!.single.openingHeight, 2.1);
      expect(data.storeys.last.elevationMetres, 3.5);
      expect(data.storeys.last.plan.openings!.windows!.single.id, '3OwCeSUdXINgnzMRYoqM8n');
      expect(data.storeys.last.plan.openings!.windows!.single.width, 1.0);
      expect(data.buildings.single.name, 'Building A');
      expect(data.storeys.first.buildingId, data.buildings.single.id);
      expect(data.mappingReport.where((m) => m.stepId != null), isNotEmpty);
    } finally { client.dispose(); }
  }, skip: _skip);

  test('DXF export sends plan/analysis and decodes dimensioned R2013 data', () async {
    late http.Request seen;
    final client = VedikaClient(apiKey: 'cad-test', httpClient: MockClient((r) async {
      seen = r;
      return fixture('export-dxf');
    }));
    try {
      final plan = {'rooms': <dynamic>[]};
      final result = await client.cad.exportDxf(VastuPlanExportDxfRequest(
          plan: plan, analysis: {'findings': <dynamic>[]}, zones: 32,
          unitsCode: 4, trueNorthDeg: 30, maxChargeUsd: '0.10'),
          idempotencyKey: 'cad:export');
      expect(seen.url.path, '/v2/astrology/vastu/plan/export-dxf');
      expect(jsonDecode(seen.body)['zones'], 32);
      expect(jsonDecode(seen.body)['unitsCode'], 4);
      expect(plan, {'rooms': <dynamic>[]});
      final data = result.data!;
      expect(data.version, 'R2013');
      expect(data.dxf, contains('AC1027'));
      expect(data.contentType, 'application/dxf');
      expect(data.unitsCode, 4);
      expect(data.roomCount, 3);
      expect(data.dimensionCount, greaterThan(0));
      expect(data.findingCount, 1);
      expect(data.needsReview, isFalse);
    } finally { client.dispose(); }
  }, skip: _skip);

  test('bad exact budgets and header injection are rejected before transport', () async {
    var sends = 0;
    final client = VedikaClient(apiKey: 'cad-test', httpClient: MockClient((r) async {
      sends++;
      return fixture('import-dxf');
    }));
    try {
      for (final budget in ['-1', '0.001', '1e-2', 'NaN', '01.00', '0.01\n']) {
        await expectLater(client.cad.importDxf(
          VastuPlanImportDxfRequest(dxf: 'DXF', maxChargeUsd: budget)),
          throwsArgumentError);
      }
      for (final key in ['', ' ', 'x\r\nAuthorization: attacker']) {
        await expectLater(client.cad.importIfc(
          const VastuPlanImportIfcRequest(ifc: 'STEP'), idempotencyKey: key),
          throwsArgumentError);
      }
      expect(sends, 0);
    } finally { client.dispose(); }
  });

  test('DWG 415 and redirects retain native errors', () async {
    for (final status in [415, 302]) {
      var sends = 0;
      final client = VedikaClient(apiKey: 'cad-test', httpClient: MockClient((r) async {
        sends++;
        expect(r.followRedirects, isFalse);
        return http.Response('{"error":"convert DWG to DXF"}', status,
            headers: {'location': 'https://attacker.invalid'});
      }));
      try {
        await expectLater(client.cad.importDxf(
            const VastuPlanImportDxfRequest(dxf: 'DWG', fileName: 'rooms.dwg')),
            throwsA(isA<VedikaApiError>().having((e) => e.statusCode, 'status', status)));
        expect(sends, 1);
      } finally { client.dispose(); }
    }
  });

  test('nested holes and missing optional fields decode without losing geometry', () {
    final room = VastuPlanImportDxfDataPlanRoomsItem.fromJson({
      'id': 'room', 'name': 'Kitchen', 'polygon': [[0, 0], [4, 0], [4, 3], [0, 3]],
      'holes': [[[1, 1], [2, 1], [2, 2], [1, 2]]], 'area': 11,
    });
    expect(room.holes!.single.first, <double>[1, 1]);
    expect(room.polygon[2], <double>[4, 3]);
    expect(room.area, 11.0);
    expect(room.labelEntityId, isNull);
    expect(room.source, isNull);
    expect(room.centre, isNull);
  });
}
