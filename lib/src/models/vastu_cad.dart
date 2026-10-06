// Generated CAD response models; run scripts/sdks/sync-vastu-response-types.py.

class VastuPlanImportDxfDataPlanPlot {
  final Map<String, dynamic> raw;
  VastuPlanImportDxfDataPlanPlot.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  double get width => (raw['width'] as num).toDouble();
  double get length => (raw['length'] as num).toDouble();
  List<List<double>>? get polygon => raw['polygon'] == null ? null : (raw['polygon'] as List).map((value0) => (value0 as List).map((value1) => (value1 as num).toDouble()).toList(growable: false)).toList(growable: false);
  String? get units => raw['units'] == null ? null : (raw['units'] as String);
}

class VastuPlanImportDxfDataPlanRoomsItem {
  final Map<String, dynamic> raw;
  VastuPlanImportDxfDataPlanRoomsItem.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get id => (raw['id'] as String);
  String get name => (raw['name'] as String);
  List<List<double>> get polygon => (raw['polygon'] as List).map((value0) => (value0 as List).map((value1) => (value1 as num).toDouble()).toList(growable: false)).toList(growable: false);
  double? get x => raw['x'] == null ? null : (raw['x'] as num).toDouble();
  double? get y => raw['y'] == null ? null : (raw['y'] as num).toDouble();
  double? get w => raw['w'] == null ? null : (raw['w'] as num).toDouble();
  double? get h => raw['h'] == null ? null : (raw['h'] as num).toDouble();
  double? get area => raw['area'] == null ? null : (raw['area'] as num).toDouble();
  List<double>? get centre => raw['centre'] == null ? null : (raw['centre'] as List).map((value0) => (value0 as num).toDouble()).toList(growable: false);
  List<List<List<double>>>? get holes => raw['holes'] == null ? null : (raw['holes'] as List).map((value0) => (value0 as List).map((value1) => (value1 as List).map((value2) => (value2 as num).toDouble()).toList(growable: false)).toList(growable: false)).toList(growable: false);
  Map<String, dynamic>? get source => raw['source'] == null ? null : Map<String, dynamic>.from(raw['source'] as Map);
  String? get labelEntityId => raw['labelEntityId'] == null ? null : (raw['labelEntityId'] as String);
}

class VastuPlanImportDxfDataPlanOpeningsDoorsItem {
  final Map<String, dynamic> raw;
  VastuPlanImportDxfDataPlanOpeningsDoorsItem.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get id => (raw['id'] as String);
  String get type => (raw['type'] as String);
  List<List<double>> get line => (raw['line'] as List).map((value0) => (value0 as List).map((value1) => (value1 as num).toDouble()).toList(growable: false)).toList(growable: false);
  double get width => (raw['width'] as num).toDouble();
  List<double>? get centre => raw['centre'] == null ? null : (raw['centre'] as List).map((value0) => (value0 as num).toDouble()).toList(growable: false);
  Map<String, dynamic>? get source => raw['source'] == null ? null : Map<String, dynamic>.from(raw['source'] as Map);
}

class VastuPlanImportDxfDataPlanOpeningsWindowsItem {
  final Map<String, dynamic> raw;
  VastuPlanImportDxfDataPlanOpeningsWindowsItem.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get id => (raw['id'] as String);
  String get type => (raw['type'] as String);
  List<List<double>> get line => (raw['line'] as List).map((value0) => (value0 as List).map((value1) => (value1 as num).toDouble()).toList(growable: false)).toList(growable: false);
  double get width => (raw['width'] as num).toDouble();
  List<double>? get centre => raw['centre'] == null ? null : (raw['centre'] as List).map((value0) => (value0 as num).toDouble()).toList(growable: false);
  Map<String, dynamic>? get source => raw['source'] == null ? null : Map<String, dynamic>.from(raw['source'] as Map);
}

class VastuPlanImportDxfDataPlanOpenings {
  final Map<String, dynamic> raw;
  VastuPlanImportDxfDataPlanOpenings.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  List<VastuPlanImportDxfDataPlanOpeningsDoorsItem>? get doors => raw['doors'] == null ? null : (raw['doors'] as List).map((value0) => VastuPlanImportDxfDataPlanOpeningsDoorsItem.fromJson(Map<String, dynamic>.from(value0 as Map))).toList(growable: false);
  List<VastuPlanImportDxfDataPlanOpeningsWindowsItem>? get windows => raw['windows'] == null ? null : (raw['windows'] as List).map((value0) => VastuPlanImportDxfDataPlanOpeningsWindowsItem.fromJson(Map<String, dynamic>.from(value0 as Map))).toList(growable: false);
  String? get units => raw['units'] == null ? null : (raw['units'] as String);
}

class VastuPlanImportDxfDataPlan {
  final Map<String, dynamic> raw;
  VastuPlanImportDxfDataPlan.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  VastuPlanImportDxfDataPlanPlot get plot => VastuPlanImportDxfDataPlanPlot.fromJson(Map<String, dynamic>.from(raw['plot'] as Map));
  List<VastuPlanImportDxfDataPlanRoomsItem> get rooms => (raw['rooms'] as List).map((value0) => VastuPlanImportDxfDataPlanRoomsItem.fromJson(Map<String, dynamic>.from(value0 as Map))).toList(growable: false);
  VastuPlanImportDxfDataPlanOpenings? get openings => raw['openings'] == null ? null : VastuPlanImportDxfDataPlanOpenings.fromJson(Map<String, dynamic>.from(raw['openings'] as Map));
  double get trueNorthDeg => (raw['trueNorthDeg'] as num).toDouble();
  double? get orientationDeg => raw['orientationDeg'] == null ? null : (raw['orientationDeg'] as num).toDouble();
  String get units => (raw['units'] as String);
  Map<String, dynamic>? get cadMetadata => raw['cadMetadata'] == null ? null : Map<String, dynamic>.from(raw['cadMetadata'] as Map);
}

class VastuPlanImportDxfDataMappingReportItem {
  final Map<String, dynamic> raw;
  VastuPlanImportDxfDataMappingReportItem.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get entityId => (raw['entityId'] as String);
  String? get handle => raw['handle'] == null ? null : (raw['handle'] as String);
  int? get stepId => raw['stepId'] == null ? null : (raw['stepId'] as int);
  String get entityType => (raw['entityType'] as String);
  String? get layer => raw['layer'] == null ? null : (raw['layer'] as String);
  String? get role => raw['role'] == null ? null : (raw['role'] as String);
  String get status => (raw['status'] as String);
  List<String>? get planIds => raw['planIds'] == null ? null : (raw['planIds'] as List).map((value0) => (value0 as String)).toList(growable: false);
  String? get reason => raw['reason'] == null ? null : (raw['reason'] as String);
  String? get parentId => raw['parentId'] == null ? null : (raw['parentId'] as String);
}

class VastuPlanImportDxfDataReviewReasonsItem {
  final Map<String, dynamic> raw;
  VastuPlanImportDxfDataReviewReasonsItem.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String? get id => raw['id'] == null ? null : (raw['id'] as String);
  String get reason => (raw['reason'] as String);
}

class VastuPlanImportIfcDataBuildingsItem {
  final Map<String, dynamic> raw;
  VastuPlanImportIfcDataBuildingsItem.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get id => (raw['id'] as String);
  String get name => (raw['name'] as String);
}

class VastuPlanImportIfcDataStoreysItemPlanPlot {
  final Map<String, dynamic> raw;
  VastuPlanImportIfcDataStoreysItemPlanPlot.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  double get width => (raw['width'] as num).toDouble();
  double get length => (raw['length'] as num).toDouble();
  List<List<double>>? get polygon => raw['polygon'] == null ? null : (raw['polygon'] as List).map((value0) => (value0 as List).map((value1) => (value1 as num).toDouble()).toList(growable: false)).toList(growable: false);
  String? get units => raw['units'] == null ? null : (raw['units'] as String);
}

class VastuPlanImportIfcDataStoreysItemPlanRoomsItem {
  final Map<String, dynamic> raw;
  VastuPlanImportIfcDataStoreysItemPlanRoomsItem.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get id => (raw['id'] as String);
  String get name => (raw['name'] as String);
  List<List<double>> get polygon => (raw['polygon'] as List).map((value0) => (value0 as List).map((value1) => (value1 as num).toDouble()).toList(growable: false)).toList(growable: false);
  double? get x => raw['x'] == null ? null : (raw['x'] as num).toDouble();
  double? get y => raw['y'] == null ? null : (raw['y'] as num).toDouble();
  double? get w => raw['w'] == null ? null : (raw['w'] as num).toDouble();
  double? get h => raw['h'] == null ? null : (raw['h'] as num).toDouble();
  double? get area => raw['area'] == null ? null : (raw['area'] as num).toDouble();
  List<double>? get centre => raw['centre'] == null ? null : (raw['centre'] as List).map((value0) => (value0 as num).toDouble()).toList(growable: false);
  List<List<List<double>>>? get holes => raw['holes'] == null ? null : (raw['holes'] as List).map((value0) => (value0 as List).map((value1) => (value1 as List).map((value2) => (value2 as num).toDouble()).toList(growable: false)).toList(growable: false)).toList(growable: false);
  Map<String, dynamic>? get source => raw['source'] == null ? null : Map<String, dynamic>.from(raw['source'] as Map);
}

class VastuPlanImportIfcDataStoreysItemPlanOpeningsDoorsItem {
  final Map<String, dynamic> raw;
  VastuPlanImportIfcDataStoreysItemPlanOpeningsDoorsItem.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get id => (raw['id'] as String);
  String get type => (raw['type'] as String);
  List<List<double>> get line => (raw['line'] as List).map((value0) => (value0 as List).map((value1) => (value1 as num).toDouble()).toList(growable: false)).toList(growable: false);
  double get width => (raw['width'] as num).toDouble();
  List<double>? get centre => raw['centre'] == null ? null : (raw['centre'] as List).map((value0) => (value0 as num).toDouble()).toList(growable: false);
  Map<String, dynamic>? get source => raw['source'] == null ? null : Map<String, dynamic>.from(raw['source'] as Map);
  String? get name => raw['name'] == null ? null : (raw['name'] as String);
  double? get openingHeight => raw['openingHeight'] == null ? null : (raw['openingHeight'] as num).toDouble();
}

class VastuPlanImportIfcDataStoreysItemPlanOpeningsWindowsItem {
  final Map<String, dynamic> raw;
  VastuPlanImportIfcDataStoreysItemPlanOpeningsWindowsItem.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get id => (raw['id'] as String);
  String get type => (raw['type'] as String);
  List<List<double>> get line => (raw['line'] as List).map((value0) => (value0 as List).map((value1) => (value1 as num).toDouble()).toList(growable: false)).toList(growable: false);
  double get width => (raw['width'] as num).toDouble();
  List<double>? get centre => raw['centre'] == null ? null : (raw['centre'] as List).map((value0) => (value0 as num).toDouble()).toList(growable: false);
  Map<String, dynamic>? get source => raw['source'] == null ? null : Map<String, dynamic>.from(raw['source'] as Map);
  String? get name => raw['name'] == null ? null : (raw['name'] as String);
  double? get openingHeight => raw['openingHeight'] == null ? null : (raw['openingHeight'] as num).toDouble();
}

class VastuPlanImportIfcDataStoreysItemPlanOpenings {
  final Map<String, dynamic> raw;
  VastuPlanImportIfcDataStoreysItemPlanOpenings.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  List<VastuPlanImportIfcDataStoreysItemPlanOpeningsDoorsItem>? get doors => raw['doors'] == null ? null : (raw['doors'] as List).map((value0) => VastuPlanImportIfcDataStoreysItemPlanOpeningsDoorsItem.fromJson(Map<String, dynamic>.from(value0 as Map))).toList(growable: false);
  List<VastuPlanImportIfcDataStoreysItemPlanOpeningsWindowsItem>? get windows => raw['windows'] == null ? null : (raw['windows'] as List).map((value0) => VastuPlanImportIfcDataStoreysItemPlanOpeningsWindowsItem.fromJson(Map<String, dynamic>.from(value0 as Map))).toList(growable: false);
  String? get units => raw['units'] == null ? null : (raw['units'] as String);
}

class VastuPlanImportIfcDataStoreysItemPlan {
  final Map<String, dynamic> raw;
  VastuPlanImportIfcDataStoreysItemPlan.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  VastuPlanImportIfcDataStoreysItemPlanPlot get plot => VastuPlanImportIfcDataStoreysItemPlanPlot.fromJson(Map<String, dynamic>.from(raw['plot'] as Map));
  List<VastuPlanImportIfcDataStoreysItemPlanRoomsItem> get rooms => (raw['rooms'] as List).map((value0) => VastuPlanImportIfcDataStoreysItemPlanRoomsItem.fromJson(Map<String, dynamic>.from(value0 as Map))).toList(growable: false);
  VastuPlanImportIfcDataStoreysItemPlanOpenings? get openings => raw['openings'] == null ? null : VastuPlanImportIfcDataStoreysItemPlanOpenings.fromJson(Map<String, dynamic>.from(raw['openings'] as Map));
  double get trueNorthDeg => (raw['trueNorthDeg'] as num).toDouble();
  double? get orientationDeg => raw['orientationDeg'] == null ? null : (raw['orientationDeg'] as num).toDouble();
  String get units => (raw['units'] as String);
  Map<String, dynamic>? get cadMetadata => raw['cadMetadata'] == null ? null : Map<String, dynamic>.from(raw['cadMetadata'] as Map);
}

class VastuPlanImportIfcDataStoreysItem {
  final Map<String, dynamic> raw;
  VastuPlanImportIfcDataStoreysItem.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get id => (raw['id'] as String);
  String get name => (raw['name'] as String);
  String? get buildingId => raw['buildingId'] == null ? null : (raw['buildingId'] as String);
  double? get elevationMetres => raw['elevationMetres'] == null ? null : (raw['elevationMetres'] as num).toDouble();
  VastuPlanImportIfcDataStoreysItemPlan get plan => VastuPlanImportIfcDataStoreysItemPlan.fromJson(Map<String, dynamic>.from(raw['plan'] as Map));
}

class VastuPlanImportIfcDataMappingReportItem {
  final Map<String, dynamic> raw;
  VastuPlanImportIfcDataMappingReportItem.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get entityId => (raw['entityId'] as String);
  String? get handle => raw['handle'] == null ? null : (raw['handle'] as String);
  int? get stepId => raw['stepId'] == null ? null : (raw['stepId'] as int);
  String get entityType => (raw['entityType'] as String);
  String? get layer => raw['layer'] == null ? null : (raw['layer'] as String);
  String? get role => raw['role'] == null ? null : (raw['role'] as String);
  String get status => (raw['status'] as String);
  List<String>? get planIds => raw['planIds'] == null ? null : (raw['planIds'] as List).map((value0) => (value0 as String)).toList(growable: false);
  String? get reason => raw['reason'] == null ? null : (raw['reason'] as String);
  String? get storeyId => raw['storeyId'] == null ? null : (raw['storeyId'] as String);
}

class VastuPlanImportIfcDataReviewReasonsItem {
  final Map<String, dynamic> raw;
  VastuPlanImportIfcDataReviewReasonsItem.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String? get id => raw['id'] == null ? null : (raw['id'] as String);
  String get reason => (raw['reason'] as String);
}

class VastuPlanImportDxfData {
  final Map<String, dynamic> raw;
  VastuPlanImportDxfData.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  VastuPlanImportDxfDataPlan get plan => VastuPlanImportDxfDataPlan.fromJson(Map<String, dynamic>.from(raw['plan'] as Map));
  List<VastuPlanImportDxfDataMappingReportItem> get mappingReport => (raw['mappingReport'] as List).map((value0) => VastuPlanImportDxfDataMappingReportItem.fromJson(Map<String, dynamic>.from(value0 as Map))).toList(growable: false);
  bool get needsReview => (raw['needsReview'] as bool);
  List<VastuPlanImportDxfDataReviewReasonsItem> get reviewReasons => (raw['reviewReasons'] as List).map((value0) => VastuPlanImportDxfDataReviewReasonsItem.fromJson(Map<String, dynamic>.from(value0 as Map))).toList(growable: false);
  Map<String, dynamic>? get pricing => raw['pricing'] == null ? null : Map<String, dynamic>.from(raw['pricing'] as Map);
  String? get rulesVersion => raw['rulesVersion'] == null ? null : (raw['rulesVersion'] as String);
  String? get units => raw['units'] == null ? null : (raw['units'] as String);
  String? get inputUnits => raw['inputUnits'] == null ? null : (raw['inputUnits'] as String);
  double? get metresPerInputUnit => raw['metresPerInputUnit'] == null ? null : (raw['metresPerInputUnit'] as num).toDouble();
}

class VastuPlanImportIfcData {
  final Map<String, dynamic> raw;
  VastuPlanImportIfcData.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get schema => (raw['schema'] as String);
  List<VastuPlanImportIfcDataBuildingsItem> get buildings => (raw['buildings'] as List).map((value0) => VastuPlanImportIfcDataBuildingsItem.fromJson(Map<String, dynamic>.from(value0 as Map))).toList(growable: false);
  List<VastuPlanImportIfcDataStoreysItem> get storeys => (raw['storeys'] as List).map((value0) => VastuPlanImportIfcDataStoreysItem.fromJson(Map<String, dynamic>.from(value0 as Map))).toList(growable: false);
  double get trueNorthDeg => (raw['trueNorthDeg'] as num).toDouble();
  List<VastuPlanImportIfcDataMappingReportItem> get mappingReport => (raw['mappingReport'] as List).map((value0) => VastuPlanImportIfcDataMappingReportItem.fromJson(Map<String, dynamic>.from(value0 as Map))).toList(growable: false);
  bool get needsReview => (raw['needsReview'] as bool);
  List<VastuPlanImportIfcDataReviewReasonsItem> get reviewReasons => (raw['reviewReasons'] as List).map((value0) => VastuPlanImportIfcDataReviewReasonsItem.fromJson(Map<String, dynamic>.from(value0 as Map))).toList(growable: false);
  Map<String, dynamic>? get pricing => raw['pricing'] == null ? null : Map<String, dynamic>.from(raw['pricing'] as Map);
  String? get rulesVersion => raw['rulesVersion'] == null ? null : (raw['rulesVersion'] as String);
  String? get units => raw['units'] == null ? null : (raw['units'] as String);
  String? get inputUnits => raw['inputUnits'] == null ? null : (raw['inputUnits'] as String);
  double? get metresPerInputUnit => raw['metresPerInputUnit'] == null ? null : (raw['metresPerInputUnit'] as num).toDouble();
}

class VastuPlanExportDxfData {
  final Map<String, dynamic> raw;
  VastuPlanExportDxfData.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get dxf => (raw['dxf'] as String);
  String get contentType => (raw['contentType'] as String);
  String get fileName => (raw['fileName'] as String);
  String get version => (raw['version'] as String);
  int get unitsCode => (raw['unitsCode'] as int);
  double get trueNorthDeg => (raw['trueNorthDeg'] as num).toDouble();
  int get zones => (raw['zones'] as int);
  int get roomCount => (raw['roomCount'] as int);
  int get openingCount => (raw['openingCount'] as int);
  int get dimensionCount => (raw['dimensionCount'] as int);
  int get findingCount => (raw['findingCount'] as int);
  bool get needsReview => (raw['needsReview'] as bool);
  Map<String, dynamic>? get pricing => raw['pricing'] == null ? null : Map<String, dynamic>.from(raw['pricing'] as Map);
  String? get rulesVersion => raw['rulesVersion'] == null ? null : (raw['rulesVersion'] as String);
  String? get units => raw['units'] == null ? null : (raw['units'] as String);
  String? get inputUnits => raw['inputUnits'] == null ? null : (raw['inputUnits'] as String);
  double? get metresPerInputUnit => raw['metresPerInputUnit'] == null ? null : (raw['metresPerInputUnit'] as num).toDouble();
}

class VastuPlanExportIfcData {
  final Map<String, dynamic> raw;
  VastuPlanExportIfcData.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get ifc => (raw['ifc'] as String);
  String get schema => (raw['schema'] as String);
  String get contentType => (raw['contentType'] as String);
  String get fileName => (raw['fileName'] as String);
  String get outputUnits => (raw['outputUnits'] as String);
  String? get units => raw['units'] == null ? null : (raw['units'] as String);
  int get roomCount => (raw['roomCount'] as int);
  Map<String, dynamic>? get pricing => raw['pricing'] == null ? null : Map<String, dynamic>.from(raw['pricing'] as Map);
  String? get inputUnits => raw['inputUnits'] == null ? null : (raw['inputUnits'] as String);
  double? get metresPerInputUnit => raw['metresPerInputUnit'] == null ? null : (raw['metresPerInputUnit'] as num).toDouble();
  String get canonicalUnits => (raw['canonicalUnits'] as String);
}

class VastuPlanConvertUnitsData {
  final Map<String, dynamic> raw;
  VastuPlanConvertUnitsData.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  Map<String, dynamic> get plan => Map<String, dynamic>.from(raw['plan'] as Map);
  String get inputUnits => (raw['inputUnits'] as String);
  String get outputUnits => (raw['outputUnits'] as String);
  double get scaleFactor => (raw['scaleFactor'] as num).toDouble();
  String get canonicalUnits => (raw['canonicalUnits'] as String);
  Map<String, dynamic>? get pricing => raw['pricing'] == null ? null : Map<String, dynamic>.from(raw['pricing'] as Map);
  String? get units => raw['units'] == null ? null : (raw['units'] as String);
  double? get metresPerInputUnit => raw['metresPerInputUnit'] == null ? null : (raw['metresPerInputUnit'] as num).toDouble();
}

class VastuDrawingSheetData {
  final Map<String, dynamic> raw;
  VastuDrawingSheetData.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get html => (raw['html'] as String);
  String get svg => (raw['svg'] as String);
  String get paperSize => (raw['paperSize'] as String);
  double get paperWidthMm => (raw['paperWidthMm'] as num).toDouble();
  double get paperHeightMm => (raw['paperHeightMm'] as num).toDouble();
  int get scaleDenominator => (raw['scaleDenominator'] as int);
  double get metresToPaperMm => (raw['metresToPaperMm'] as num).toDouble();
  double get planWidthMm => (raw['planWidthMm'] as num).toDouble();
  double get planHeightMm => (raw['planHeightMm'] as num).toDouble();
  double get trueNorthDeg => (raw['trueNorthDeg'] as num).toDouble();
  int get fieldEvidenceCount => (raw['fieldEvidenceCount'] as int);
  String? get contentType => raw['contentType'] == null ? null : (raw['contentType'] as String);
  String? get pdfBase64 => raw['pdfBase64'] == null ? null : (raw['pdfBase64'] as String);
  String get inputUnits => (raw['inputUnits'] as String);
  String get units => (raw['units'] as String);
  double get metresPerInputUnit => (raw['metresPerInputUnit'] as num).toDouble();
}

class VastuWorkspaceData {
  final Map<String, dynamic> raw;
  VastuWorkspaceData.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  Map<String, dynamic>? get record => raw['record'] == null ? null : Map<String, dynamic>.from(raw['record'] as Map);
  bool? get replayed => raw['replayed'] == null ? null : (raw['replayed'] as bool);
  List<Map<String, dynamic>>? get records => raw['records'] == null ? null : (raw['records'] as List).map((value0) => Map<String, dynamic>.from(value0 as Map)).toList(growable: false);
  String? get id => raw['id'] == null ? null : (raw['id'] as String);
  String? get title => raw['title'] == null ? null : (raw['title'] as String);
  int? get expiresAt => raw['expiresAt'] == null ? null : (raw['expiresAt'] as int);
  bool? get reset => raw['reset'] == null ? null : (raw['reset'] as bool);
  int? get deletedRecords => raw['deletedRecords'] == null ? null : (raw['deletedRecords'] as int);
  String? get payload => raw['payload'] == null ? null : (raw['payload'] as String);
  Map<String, dynamic>? get headers => raw['headers'] == null ? null : Map<String, dynamic>.from(raw['headers'] as Map);
  String? get deliveryMode => raw['deliveryMode'] == null ? null : (raw['deliveryMode'] as String);
  int? get retentionDays => raw['retentionDays'] == null ? null : (raw['retentionDays'] as int);
  int? get maxRecords => raw['maxRecords'] == null ? null : (raw['maxRecords'] as int);
  String? get html => raw['html'] == null ? null : (raw['html'] as String);
  String? get svg => raw['svg'] == null ? null : (raw['svg'] as String);
}
