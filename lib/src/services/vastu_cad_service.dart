import '../client.dart';
import '../models/common.dart';
import '../models/vastu_cad.dart';
import '../models/vastu_cad_requests.dart';

/// Paid CAD/BIM operations under `/v2/astrology/vastu/plan/`.
class VastuCadService {
  final VedikaClient _client;
  VastuCadService(this._client);

  /// Import DXF rooms, labels and openings. Retain the key when retrying.
  Future<VedikaResponse<VastuPlanImportDxfData>> importDxf(
    VastuPlanImportDxfRequest request, {
    String? idempotencyKey,
  }) async => VedikaResponse.fromJson(
      await _client.post('/v2/astrology/vastu/plan/import-dxf', request.toJson(),
          idempotencyKey: idempotencyKey),
      (data) => VastuPlanImportDxfData.fromJson(Map<String, dynamic>.from(data as Map)));

  /// Import IFC spaces per storey, preserving GlobalIds and true north.
  Future<VedikaResponse<VastuPlanImportIfcData>> importIfc(
    VastuPlanImportIfcRequest request, {
    String? idempotencyKey,
  }) async => VedikaResponse.fromJson(
      await _client.post('/v2/astrology/vastu/plan/import-ifc', request.toJson(),
          idempotencyKey: idempotencyKey),
      (data) => VastuPlanImportIfcData.fromJson(Map<String, dynamic>.from(data as Map)));

  /// Export editable DXF in source units, with dimensions and Vastu overlays.
  Future<VedikaResponse<VastuPlanExportDxfData>> exportDxf(
    VastuPlanExportDxfRequest request, {
    String? idempotencyKey,
  }) async => VedikaResponse.fromJson(
      await _client.post('/v2/astrology/vastu/plan/export-dxf', request.toJson(),
          idempotencyKey: idempotencyKey),
      (data) => VastuPlanExportDxfData.fromJson(Map<String, dynamic>.from(data as Map)));


  Future<VedikaResponse<VastuPlanExportIfcData>> exportIfc(VastuPlanExportIfcRequest request, {String? idempotencyKey}) async => VedikaResponse.fromJson(
    await _client.post('/v2/astrology/vastu/plan/export-ifc',request.toJson(),idempotencyKey:idempotencyKey),
    (data)=>VastuPlanExportIfcData.fromJson(Map<String,dynamic>.from(data as Map)));
  Future<VedikaResponse<VastuPlanConvertUnitsData>> convertUnits(VastuPlanConvertUnitsRequest request) async => VedikaResponse.fromJson(
    await _client.post('/v2/astrology/vastu/plan/convert-units',request.toJson()),
    (data)=>VastuPlanConvertUnitsData.fromJson(Map<String,dynamic>.from(data as Map)));
}
