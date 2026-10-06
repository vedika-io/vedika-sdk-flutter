import '../client.dart';
import '../models/common.dart';
import '../models/vastu_rules.dart';

class VastuRulesService {
  final VedikaClient _client;
  VastuRulesService(this._client);
  Future<VedikaResponse<VastuRuleVersions>> versions() async => VedikaResponse.fromJson(
      await _client.get('/v2/astrology/vastu/rules/versions'),
      (data) => VastuRuleVersions.fromJson(Map<String, dynamic>.from(data as Map)));
  Future<VedikaResponse<VastuRuleComparison>> compareVersions({
    required String fromVersion, required String toVersion,
    required Map<String, dynamic> input, String operation = 'plan/analyze',
    String? idempotencyKey,
  }) async => VedikaResponse.fromJson(
      await _client.post('/v2/astrology/vastu/plan/compare-versions',
          {'fromVersion': fromVersion, 'toVersion': toVersion, 'operation': operation, 'input': input},
          idempotencyKey: idempotencyKey),
      (data) => VastuRuleComparison.fromJson(Map<String, dynamic>.from(data as Map)));
  Future<VedikaResponse<VastuReceiptVerification>> verifyReceipt(String token, {Map<String, dynamic>? input}) async => VedikaResponse.fromJson(
      await _client.post('/v2/astrology/vastu/receipt/verify', {'token': token, if (input != null) 'input': input}),
      (data) => VastuReceiptVerification.fromJson(Map<String, dynamic>.from(data as Map)));
}
