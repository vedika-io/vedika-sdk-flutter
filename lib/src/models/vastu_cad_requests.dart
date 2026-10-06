/// Layer classification overrides for DXF intake.
enum VastuCadLayerRole { room, plot, door, window, label, hole, ignore }

void _validateCadMaxCharge(String? value) {
  if (value == null) return;
  final match = RegExp(r'^(0|[1-9][0-9]*)(\.[0-9]{1,2})?$').firstMatch(value);
  if (match == null || match.end != value.length) {
    throw ArgumentError.value(value, 'maxChargeUsd',
        'use an exact nonnegative USD string with at most two decimal places');
  }
}

/// DXF intake request. Unit codes follow the drawing's INSUNITS table.
class VastuPlanImportDxfRequest {
  final String dxf;
  final String? fileName;
  final String? contentType;
  final double? trueNorthDeg;
  final int? unitsOverride;
  final Map<String, VastuCadLayerRole>? layerRoles;
  final String? maxChargeUsd;

  const VastuPlanImportDxfRequest({required this.dxf, this.fileName,
    this.contentType, this.trueNorthDeg, this.unitsOverride, this.layerRoles,
    this.maxChargeUsd});

  Map<String, dynamic> toJson() {
    _validateCadMaxCharge(maxChargeUsd);
    return {
      'dxf': dxf,
      if (fileName != null) 'fileName': fileName,
      if (contentType != null) 'contentType': contentType,
      if (trueNorthDeg != null) 'trueNorthDeg': trueNorthDeg,
      if (unitsOverride != null) 'unitsOverride': unitsOverride,
      if (layerRoles != null) 'layerRoles': layerRoles!.map(
          (layer, role) => MapEntry(layer, role.name)),
      if (maxChargeUsd != null) 'maxChargeUsd': maxChargeUsd,
    };
  }
}

/// IFC2x3/IFC4 STEP intake request.
class VastuPlanImportIfcRequest {
  final String ifc;
  final double? trueNorthDeg;
  final String? maxChargeUsd;

  const VastuPlanImportIfcRequest({required this.ifc, this.trueNorthDeg,
    this.maxChargeUsd});

  Map<String, dynamic> toJson() {
    _validateCadMaxCharge(maxChargeUsd);
    return {
      'ifc': ifc,
      if (trueNorthDeg != null) 'trueNorthDeg': trueNorthDeg,
      if (maxChargeUsd != null) 'maxChargeUsd': maxChargeUsd,
    };
  }
}

/// Export a canonical plan, retaining source metadata from CAD intake.
class VastuPlanExportDxfRequest {
  final Map<String, dynamic> plan;
  final Map<String, dynamic>? analysis;
  final int? zones;
  final int? unitsCode;
  final double? trueNorthDeg;
  final String? maxChargeUsd;

  const VastuPlanExportDxfRequest({required this.plan, this.analysis, this.zones,
    this.unitsCode, this.trueNorthDeg, this.maxChargeUsd});

  Map<String, dynamic> toJson() {
    _validateCadMaxCharge(maxChargeUsd);
    return {
      'plan': plan,
      if (analysis != null) 'analysis': analysis,
      if (zones != null) 'zones': zones,
      if (unitsCode != null) 'unitsCode': unitsCode,
      if (trueNorthDeg != null) 'trueNorthDeg': trueNorthDeg,
      if (maxChargeUsd != null) 'maxChargeUsd': maxChargeUsd,
    };
  }
}

class VastuPlanExportIfcRequest {
  final Map<String, dynamic> plan;
  final String? outputUnits;
  final String? maxChargeUsd;
  const VastuPlanExportIfcRequest({required this.plan, this.outputUnits, this.maxChargeUsd});
  Map<String, dynamic> toJson() => {'plan':plan, if(outputUnits!=null)'outputUnits':outputUnits, if(maxChargeUsd!=null)'maxChargeUsd':maxChargeUsd};
}
class VastuPlanConvertUnitsRequest {
  final Map<String, dynamic> plan;
  final String inputUnits;
  final String outputUnits;
  const VastuPlanConvertUnitsRequest({required this.plan,required this.inputUnits,required this.outputUnits});
  Map<String, dynamic> toJson() => {'plan':plan,'inputUnits':inputUnits,'outputUnits':outputUnits};
}
