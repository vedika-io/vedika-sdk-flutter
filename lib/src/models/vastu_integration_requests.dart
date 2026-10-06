class VastuDrawingSheetRequest {
  final Map<String, dynamic> plan;
  final Map<String, String> titleBlock;
  final String paperSize;
  final int scaleDenominator;
  final String format;
  final bool dimensions;
  final bool zoneOverlay;
  final List<Map<String, dynamic>> fieldEvidence;
  const VastuDrawingSheetRequest({required this.plan, required this.titleBlock,
    this.paperSize = 'A3', this.scaleDenominator = 100, this.format = 'html',
    this.dimensions = true, this.zoneOverlay = true, this.fieldEvidence = const []});
  Map<String, dynamic> toJson() => {'plan': plan, 'titleBlock': titleBlock,
    'paperSize': paperSize, 'scaleDenominator': scaleDenominator, 'format': format,
    'dimensions': dimensions, 'zoneOverlay': zoneOverlay, 'fieldEvidence': fieldEvidence};
}
enum VastuWorkspaceOperation { properties, jobs, get, list, reset, webhook, report }
class VastuWorkspaceRequest {
  final String? propertyId;
  final String? jobId;
  final String? idempotencyKey;
  final String? title;
  final Map<String, dynamic>? input;
  final String? outcome;
  final String? webhookSecret;
  final VastuDrawingSheetRequest? drawing;
  const VastuWorkspaceRequest({this.propertyId, this.jobId, this.idempotencyKey,
    this.title, this.input, this.outcome, this.webhookSecret, this.drawing});
  Map<String, dynamic> toJson() => {
    if (propertyId != null) 'propertyId': propertyId,
    if (jobId != null) 'jobId': jobId,
    if (idempotencyKey != null) 'idempotencyKey': idempotencyKey,
    if (title != null) 'title': title,
    if (input != null) 'input': input,
    if (outcome != null) 'outcome': outcome,
    if (webhookSecret != null) 'webhookSecret': webhookSecret,
    if (drawing != null) 'drawing': drawing!.toJson(),
  };
}
