import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:vedika_sdk/vedika_sdk.dart';

void main() {
  test('invite decodes opaque 202 pending data and retains consent input', () async {
    late http.Request seen;
    final client = VedikaClient(apiKey: 'invite-test', httpClient: MockClient((r) async {
      seen = r;
      final accepted = (jsonDecode(r.body) as Map)['accept'] == true;
      return http.Response(jsonEncode({
        'success': true,
        'data': {'invitationId': '00000000-0000-4000-8000-000000000001', 'status': accepted ? 'accepted' : 'pending'},
        'billing': {'chargedCents': 0},
      }), accepted ? 200 : 202, headers: {'content-type': 'application/json'});
    }));
    try {
      final result = await VastuCollaborationService(client).propertiesCollaborationInvite(
        const VastuPropertiesCollaborationInviteRequest(
          propertyId: 'property-fixture', ownerId: 'synthetic-owner',
          email: 'synthetic@example.invalid', role: 'viewer'));
      expect(result.success, isTrue);
      expect(result.data!.status, 'pending');
      expect(result.data!.invitationId, '00000000-0000-4000-8000-000000000001');
      final accepted = await VastuCollaborationService(client).propertiesCollaborationInvite(
        const VastuPropertiesCollaborationInviteRequest(
          propertyId: 'property-fixture', ownerId: 'synthetic-owner',
          email: 'synthetic@example.invalid', role: 'viewer', accept: true));
      expect(accepted.data!.status, 'accepted');
      expect(seen.url.path, '/v2/astrology/vastu/properties/collaboration/invite');
      expect((jsonDecode(seen.body) as Map)['accept'], isTrue);
      expect(seen.followRedirects, isFalse);
    } finally { client.dispose(); }
  });
}
