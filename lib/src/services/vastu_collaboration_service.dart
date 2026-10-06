import '../client.dart';
import '../models/common.dart';
import '../models/vastu_collaboration.dart';
import '../models/vastu_collaboration_requests.dart';

class VastuCollaborationService {
  final VedikaClient _client;
  VastuCollaborationService(this._client);

  Future<VedikaResponse<VastuPropertiesCollaborationGetData>> propertiesCollaborationGet(VastuPropertiesCollaborationGetRequest request, {String? idempotencyKey}) async => VedikaResponse.fromJson(
    await _client.post("/v2/astrology/vastu/properties/collaboration/get", request.toJson(), idempotencyKey: idempotencyKey),
    (data) => VastuPropertiesCollaborationGetData.fromJson(Map<String, dynamic>.from(data as Map)));

  Future<VedikaResponse<VastuPropertiesCollaborationInviteData>> propertiesCollaborationInvite(VastuPropertiesCollaborationInviteRequest request, {String? idempotencyKey}) async => VedikaResponse.fromJson(
    await _client.post("/v2/astrology/vastu/properties/collaboration/invite", request.toJson(), idempotencyKey: idempotencyKey),
    (data) => VastuPropertiesCollaborationInviteData.fromJson(Map<String, dynamic>.from(data as Map)));

  Future<VedikaResponse<VastuPropertiesCollaborationRevokeData>> propertiesCollaborationRevoke(VastuPropertiesCollaborationRevokeRequest request, {String? idempotencyKey}) async => VedikaResponse.fromJson(
    await _client.post("/v2/astrology/vastu/properties/collaboration/revoke", request.toJson(), idempotencyKey: idempotencyKey),
    (data) => VastuPropertiesCollaborationRevokeData.fromJson(Map<String, dynamic>.from(data as Map)));

  Future<VedikaResponse<VastuPropertiesCollaborationMembersData>> propertiesCollaborationMembers(VastuPropertiesCollaborationMembersRequest request, {String? idempotencyKey}) async => VedikaResponse.fromJson(
    await _client.post("/v2/astrology/vastu/properties/collaboration/members", request.toJson(), idempotencyKey: idempotencyKey),
    (data) => VastuPropertiesCollaborationMembersData.fromJson(Map<String, dynamic>.from(data as Map)));

  Future<VedikaResponse<VastuPropertiesCollaborationCommentData>> propertiesCollaborationComment(VastuPropertiesCollaborationCommentRequest request, {String? idempotencyKey}) async => VedikaResponse.fromJson(
    await _client.post("/v2/astrology/vastu/properties/collaboration/comment", request.toJson(), idempotencyKey: idempotencyKey),
    (data) => VastuPropertiesCollaborationCommentData.fromJson(Map<String, dynamic>.from(data as Map)));

  Future<VedikaResponse<VastuPropertiesCollaborationReviewData>> propertiesCollaborationReview(VastuPropertiesCollaborationReviewRequest request, {String? idempotencyKey}) async => VedikaResponse.fromJson(
    await _client.post("/v2/astrology/vastu/properties/collaboration/review", request.toJson(), idempotencyKey: idempotencyKey),
    (data) => VastuPropertiesCollaborationReviewData.fromJson(Map<String, dynamic>.from(data as Map)));

  Future<VedikaResponse<VastuPropertiesCollaborationUpdateData>> propertiesCollaborationUpdate(VastuPropertiesCollaborationUpdateRequest request, {String? idempotencyKey}) async => VedikaResponse.fromJson(
    await _client.post("/v2/astrology/vastu/properties/collaboration/update", request.toJson(), idempotencyKey: idempotencyKey),
    (data) => VastuPropertiesCollaborationUpdateData.fromJson(Map<String, dynamic>.from(data as Map)));

  Future<VedikaResponse<VastuPropertiesActivityListData>> propertiesActivityList(VastuPropertiesActivityListRequest request, {String? idempotencyKey}) async => VedikaResponse.fromJson(
    await _client.post("/v2/astrology/vastu/properties/activity/list", request.toJson(), idempotencyKey: idempotencyKey),
    (data) => VastuPropertiesActivityListData.fromJson(Map<String, dynamic>.from(data as Map)));

  Future<VedikaResponse<VastuPropertiesActivityExportData>> propertiesActivityExport(VastuPropertiesActivityExportRequest request, {String? idempotencyKey}) async => VedikaResponse.fromJson(
    await _client.post("/v2/astrology/vastu/properties/activity/export", request.toJson(), idempotencyKey: idempotencyKey),
    (data) => VastuPropertiesActivityExportData.fromJson(Map<String, dynamic>.from(data as Map)));

  Future<VedikaResponse<VastuPropertiesDeleteData>> propertiesDelete(VastuPropertiesDeleteRequest request, {String? idempotencyKey}) async => VedikaResponse.fromJson(
    await _client.post("/v2/astrology/vastu/properties/delete", request.toJson(), idempotencyKey: idempotencyKey),
    (data) => VastuPropertiesDeleteData.fromJson(Map<String, dynamic>.from(data as Map)));

}
