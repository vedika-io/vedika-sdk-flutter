// Generated workflow response models from the served OpenAPI.

class VastuRemediationTaskDataEvidenceItem {
  final Map<String, dynamic> raw;
  VastuRemediationTaskDataEvidenceItem.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get reference => (raw['reference'] as String);
  String? get photoRef => raw['photoRef'] == null ? null : (raw['photoRef'] as String);
  String? get note => raw['note'] == null ? null : (raw['note'] as String);
}

class VastuRemediationTaskDataReassessmentLinkRequest {
  final Map<String, dynamic> raw;
  VastuRemediationTaskDataReassessmentLinkRequest.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get propertyId => (raw['propertyId'] as String);
}

class VastuRemediationTaskDataReassessmentLink {
  final Map<String, dynamic> raw;
  VastuRemediationTaskDataReassessmentLink.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get operation => (raw['operation'] as String);
  String get method => (raw['method'] as String);
  VastuRemediationTaskDataReassessmentLinkRequest get request => VastuRemediationTaskDataReassessmentLinkRequest.fromJson(Map<String, dynamic>.from(raw['request'] as Map));
  String get resultPointer => (raw['resultPointer'] as String);
  String get propertyId => (raw['propertyId'] as String);
  String get taskId => (raw['taskId'] as String);
  String get assessmentId => (raw['assessmentId'] as String);
}

class VastuWorkflowDataDataItemsItem {
  final Map<String, dynamic> raw;
  VastuWorkflowDataDataItemsItem.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get remedyKey => (raw['remedyKey'] as String);
  String get itemId => (raw['itemId'] as String);
  String get kind => (raw['kind'] as String);
  String get label => (raw['label'] as String);
  String get availability => (raw['availability'] as String);
  String? get link => raw['link'] == null ? null : (raw['link'] as String);
  String? get referralRef => raw['referralRef'] == null ? null : (raw['referralRef'] as String);
}

class VastuWorkflowDataData {
  final Map<String, dynamic> raw;
  VastuWorkflowDataData.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String? get propertyId => raw['propertyId'] == null ? null : (raw['propertyId'] as String);
  String? get catalogId => raw['catalogId'] == null ? null : (raw['catalogId'] as String);
  Map<String, VastuRemediationTaskData>? get tasks => raw['tasks'] == null ? null : Map<String, dynamic>.from(raw['tasks'] as Map).map((key, value) => MapEntry(key, VastuRemediationTaskData.fromJson(Map<String, dynamic>.from(value as Map))));
  List<VastuWorkflowDataDataItemsItem>? get items => raw['items'] == null ? null : (raw['items'] as List).map((value0) => VastuWorkflowDataDataItemsItem.fromJson(Map<String, dynamic>.from(value0 as Map))).toList(growable: false);
}

class VastuWorkflowDataRemediesItemMappedItemsItem {
  final Map<String, dynamic> raw;
  VastuWorkflowDataRemediesItemMappedItemsItem.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get remedyKey => (raw['remedyKey'] as String);
  String get itemId => (raw['itemId'] as String);
  String get kind => (raw['kind'] as String);
  String get label => (raw['label'] as String);
  String get availability => (raw['availability'] as String);
  String? get link => raw['link'] == null ? null : (raw['link'] as String);
  String? get referralRef => raw['referralRef'] == null ? null : (raw['referralRef'] as String);
}

class VastuWorkflowDataRemediesItem {
  final Map<String, dynamic> raw;
  VastuWorkflowDataRemediesItem.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String? get remedyKey => raw['remedyKey'] == null ? null : (raw['remedyKey'] as String);
  String? get remedy => raw['remedy'] == null ? null : (raw['remedy'] as String);
  String? get classification => raw['classification'] == null ? null : (raw['classification'] as String);
  String? get source => raw['source'] == null ? null : (raw['source'] as String);
  List<VastuWorkflowDataRemediesItemMappedItemsItem>? get mappedItems => raw['mappedItems'] == null ? null : (raw['mappedItems'] as List).map((value0) => VastuWorkflowDataRemediesItemMappedItemsItem.fromJson(Map<String, dynamic>.from(value0 as Map))).toList(growable: false);
}

class VastuWorkflowData {
  final Map<String, dynamic> raw;
  VastuWorkflowData.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  int get revision => (raw['revision'] as int);
  String? get mutationId => raw['mutationId'] == null ? null : (raw['mutationId'] as String);
  String? get contentHash => raw['contentHash'] == null ? null : (raw['contentHash'] as String);
  int? get expiresAt => raw['expiresAt'] == null ? null : (raw['expiresAt'] as int);
  int? get updatedAt => raw['updatedAt'] == null ? null : (raw['updatedAt'] as int);
  bool? get deleted => raw['deleted'] == null ? null : (raw['deleted'] as bool);
  VastuWorkflowDataData? get data => raw['data'] == null ? null : VastuWorkflowDataData.fromJson(Map<String, dynamic>.from(raw['data'] as Map));
  List<VastuWorkflowDataRemediesItem>? get remedies => raw['remedies'] == null ? null : (raw['remedies'] as List).map((value0) => VastuWorkflowDataRemediesItem.fromJson(Map<String, dynamic>.from(value0 as Map))).toList(growable: false);
  String? get merchantCatalogId => raw['merchantCatalogId'] == null ? null : (raw['merchantCatalogId'] as String);
  int? get merchantCatalogRevision => raw['merchantCatalogRevision'] == null ? null : (raw['merchantCatalogRevision'] as int);
}

class VastuRemediationTaskData {
  final Map<String, dynamic> raw;
  VastuRemediationTaskData.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get taskId => (raw['taskId'] as String);
  String get reportRef => (raw['reportRef'] as String);
  String get findingRef => (raw['findingRef'] as String);
  String get remedyKey => (raw['remedyKey'] as String);
  String get title => (raw['title'] as String);
  String get status => (raw['status'] as String);
  String? get assignee => raw['assignee'] == null ? null : (raw['assignee'] as String);
  String? get dueDate => raw['dueDate'] == null ? null : (raw['dueDate'] as String);
  List<VastuRemediationTaskDataEvidenceItem>? get evidence => raw['evidence'] == null ? null : (raw['evidence'] as List).map((value0) => VastuRemediationTaskDataEvidenceItem.fromJson(Map<String, dynamic>.from(value0 as Map))).toList(growable: false);
  int? get createdAt => raw['createdAt'] == null ? null : (raw['createdAt'] as int);
  int? get updatedAt => raw['updatedAt'] == null ? null : (raw['updatedAt'] as int);
  int? get completedAt => raw['completedAt'] == null ? null : (raw['completedAt'] as int);
  Map<String, dynamic>? get reassessment => raw['reassessment'] == null ? null : Map<String, dynamic>.from(raw['reassessment'] as Map);
  VastuRemediationTaskDataReassessmentLink? get reassessmentLink => raw['reassessmentLink'] == null ? null : VastuRemediationTaskDataReassessmentLink.fromJson(Map<String, dynamic>.from(raw['reassessmentLink'] as Map));
  List<Map<String, dynamic>>? get history => raw['history'] == null ? null : (raw['history'] as List).map((value0) => Map<String, dynamic>.from(value0 as Map)).toList(growable: false);
}
