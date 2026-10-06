/// Options shared by the paid floor-plan file imports.
class VastuPlanImportImageRequest {
  final String fileBase64;
  final double? northBearingDeg;
  final double? scaleMetersPerUnit;
  final String? units;
  final String? inputUnits;
  final double? scaleInputUnitsPerUnit;
  const VastuPlanImportImageRequest({required this.fileBase64, this.northBearingDeg, this.scaleMetersPerUnit, this.units, this.inputUnits, this.scaleInputUnitsPerUnit});
  Map<String, dynamic> toJson() => {"fileBase64": fileBase64, if (units != null) "units": units, if (inputUnits != null) "inputUnits": inputUnits, if (scaleInputUnitsPerUnit != null) "scaleInputUnitsPerUnit": scaleInputUnitsPerUnit, if (northBearingDeg != null) "northBearingDeg": northBearingDeg, if (scaleMetersPerUnit != null) "scaleMetersPerUnit": scaleMetersPerUnit};
}
class VastuPlanImportPdfRequest extends VastuPlanImportImageRequest {
  final int page;
  const VastuPlanImportPdfRequest({required super.fileBase64, required this.page, super.northBearingDeg, super.scaleMetersPerUnit, super.units, super.inputUnits, super.scaleInputUnitsPerUnit});
  @override
  Map<String, dynamic> toJson() => {...super.toJson(), "page": page};
}
/// Imported editable plan and its required review fields.
class VastuPlanImportResponse {
  final Map<String, dynamic> raw;
  const VastuPlanImportResponse(this.raw);
  Map<String, dynamic> get data => Map<String, dynamic>.from(raw["data"] as Map);
  Map<String, dynamic> get plan => Map<String, dynamic>.from(data["plan"] as Map);
  String? get inputUnits => data["inputUnits"] as String?;
  String? get units => data["units"] as String?;
  double? get metresPerInputUnit => (data["metresPerInputUnit"] as num?)?.toDouble();
  bool get analysisReady => data["analysisReady"] as bool;
  double? get northBearingDeg => (data["north"]["bearingDeg"] as num?)?.toDouble();
  double? get scaleMetersPerUnit => (data["scale"]["metersPerUnit"] as num?)?.toDouble();
  List<Map<String, dynamic>> get needsReview => (data["needsReview"] as List).map((v) => Map<String, dynamic>.from(v as Map)).toList();
  Map<String, double> get confidence => (data["confidence"] as Map).map((k, v) => MapEntry(k as String, (v as num).toDouble()));
  Map<String, dynamic> get pricing => Map<String, dynamic>.from(data["pricing"] as Map);
}
