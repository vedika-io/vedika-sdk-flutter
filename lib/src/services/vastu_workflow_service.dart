import '../client.dart';
import '../models/common.dart';
import '../models/vastu_workflow.dart';
import '../models/vastu_workflow_requests.dart';

class VastuWorkflowService {
  final VedikaClient _client;
  VastuWorkflowService(this._client);
  Future<VedikaResponse<VastuWorkflowData>> remediationTasksUpsert(VastuRemediationTasksUpsertRequest request) async => VedikaResponse.fromJson(
    await _client.post('/v2/vastu/remediation/tasks/upsert', request.toJson()),
    (data) => VastuWorkflowData.fromJson(Map<String, dynamic>.from(data as Map)));
  Future<VedikaResponse<VastuWorkflowData>> remediationTasksList(VastuRemediationTasksListRequest request) async => VedikaResponse.fromJson(
    await _client.post('/v2/vastu/remediation/tasks/list', request.toJson()),
    (data) => VastuWorkflowData.fromJson(Map<String, dynamic>.from(data as Map)));
  Future<VedikaResponse<VastuWorkflowData>> remediationTasksDelete(VastuRemediationTasksDeleteRequest request) async => VedikaResponse.fromJson(
    await _client.post('/v2/vastu/remediation/tasks/delete', request.toJson()),
    (data) => VastuWorkflowData.fromJson(Map<String, dynamic>.from(data as Map)));
  Future<VedikaResponse<VastuWorkflowData>> remediationReassess(VastuRemediationReassessRequest request) async => VedikaResponse.fromJson(
    await _client.post('/v2/vastu/remediation/reassess', request.toJson()),
    (data) => VastuWorkflowData.fromJson(Map<String, dynamic>.from(data as Map)));
  Future<VedikaResponse<VastuWorkflowData>> merchantCatalogUpload(VastuMerchantCatalogUploadRequest request) async => VedikaResponse.fromJson(
    await _client.post('/v2/vastu/merchant/catalog/upload', request.toJson()),
    (data) => VastuWorkflowData.fromJson(Map<String, dynamic>.from(data as Map)));
  Future<VedikaResponse<VastuWorkflowData>> merchantCatalogGet(VastuMerchantCatalogGetRequest request) async => VedikaResponse.fromJson(
    await _client.post('/v2/vastu/merchant/catalog/get', request.toJson()),
    (data) => VastuWorkflowData.fromJson(Map<String, dynamic>.from(data as Map)));
  Future<VedikaResponse<VastuWorkflowData>> merchantCatalogDelete(VastuMerchantCatalogDeleteRequest request) async => VedikaResponse.fromJson(
    await _client.post('/v2/vastu/merchant/catalog/delete', request.toJson()),
    (data) => VastuWorkflowData.fromJson(Map<String, dynamic>.from(data as Map)));
  Future<VedikaResponse<VastuWorkflowData>> merchantRemedies(VastuMerchantRemediesRequest request) async => VedikaResponse.fromJson(
    await _client.post('/v2/vastu/merchant/remedies', request.toJson()),
    (data) => VastuWorkflowData.fromJson(Map<String, dynamic>.from(data as Map)));
}
