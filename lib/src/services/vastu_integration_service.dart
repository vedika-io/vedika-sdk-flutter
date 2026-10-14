import '../client.dart';
import '../models/common.dart';
import '../models/vastu_cad.dart';
import '../models/vastu_integration_requests.dart';

class VastuIntegrationService {
  final VedikaClient _client;
  VastuIntegrationService(this._client);
  Future<VedikaResponse<VastuDrawingSheetData>> drawingSheet(
    VastuDrawingSheetRequest request, {String? idempotencyKey}) async =>
      VedikaResponse.fromJson(await _client.post('/v2/vastu/report/drawing-sheet',
        request.toJson(), idempotencyKey: idempotencyKey),
        (data) => VastuDrawingSheetData.fromJson(Map<String, dynamic>.from(data as Map)));
  Future<VedikaResponse<VastuWorkspaceData>> workspace(
    VastuWorkspaceOperation operation,
    [VastuWorkspaceRequest request = const VastuWorkspaceRequest()]) async =>
      VedikaResponse.fromJson(await _client.post('/sandbox/v2/vastu/workspace/${operation.name}',
        request.toJson()),
        (data) => VastuWorkspaceData.fromJson(Map<String, dynamic>.from(data as Map)));
}
