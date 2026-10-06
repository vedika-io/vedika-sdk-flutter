import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:vedika_sdk/vedika_sdk.dart';

void main() {
  test('typed plan imports POST the image and selected PDF page', () async {
    final captured = <http.Request>[];
    final client = VedikaClient(
      apiKey: 'vk_test_x',
      httpClient: MockClient((request) async {
        captured.add(request);
        return http.Response(jsonEncode({
          'success': true,
          'data': {
            'plan': {'rooms': []},
            'analysisReady': false,
            'north': {'bearingDeg': null},
            'scale': {'metersPerUnit': null},
            'needsReview': [{'field': 'north', 'reason': 'not legible'}],
            'confidence': {'plot': 0.95},
            'pricing': {'price': '0.01'},
          },
        }), 200, headers: {'content-type': 'application/json'});
      }),
    );
    try {
      final image = await client.astrology.vastuPlanImportImage(
        const VastuPlanImportImageRequest(fileBase64: 'image-bytes'),
      );
      final pdf = await client.astrology.vastuPlanImportPdf(
        const VastuPlanImportPdfRequest(
          fileBase64: 'pdf-bytes', page: 2,
          northBearingDeg: 90, scaleMetersPerUnit: 0.25,
        ),
      );
      expect(captured.map((r) => r.method), ['POST', 'POST']);
      expect(captured.map((r) => r.url.path), [
        '/v2/astrology/vastu/plan/import-image',
        '/v2/astrology/vastu/plan/import-pdf',
      ]);
      expect(jsonDecode(captured[0].body), {'fileBase64': 'image-bytes'});
      expect(jsonDecode(captured[1].body), {
        'fileBase64': 'pdf-bytes', 'page': 2,
        'northBearingDeg': 90, 'scaleMetersPerUnit': 0.25,
      });
      expect(image.plan['rooms'], isEmpty);
      expect(pdf.analysisReady, isFalse);
      expect(pdf.northBearingDeg, isNull);
      expect(pdf.scaleMetersPerUnit, isNull);
      expect(pdf.needsReview.single['field'], 'north');
      expect(pdf.confidence['plot'], 0.95);
      expect(pdf.pricing['price'], '0.01');
    } finally {
      client.dispose();
    }
  });
}
