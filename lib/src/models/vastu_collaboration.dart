// Generated property response models; run scripts/sdks/sync-vastu-response-types.py.

class VastuArchiveDeleteDataErasureReceiptRemovedItem {
  final Map<String, dynamic> raw;
  VastuArchiveDeleteDataErasureReceiptRemovedItem.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get kind => (raw['kind'] as String);
  String? get recordId => raw['recordId'] == null ? null : (raw['recordId'] as String);
  String? get artifactId => raw['artifactId'] == null ? null : (raw['artifactId'] as String);
  String? get artifactHash => raw['artifactHash'] == null ? null : (raw['artifactHash'] as String);
  String? get versionHash => raw['versionHash'] == null ? null : (raw['versionHash'] as String);
  bool? get deleteMarker => raw['deleteMarker'] == null ? null : (raw['deleteMarker'] as bool);
  int? get versionCount => raw['versionCount'] == null ? null : (raw['versionCount'] as int);
  int? get deleteMarkerCount => raw['deleteMarkerCount'] == null ? null : (raw['deleteMarkerCount'] as int);
  String? get versionsSha256 => raw['versionsSha256'] == null ? null : (raw['versionsSha256'] as String);
}

class VastuArchiveDeleteDataErasureReceiptRetainedItem {
  final Map<String, dynamic> raw;
  VastuArchiveDeleteDataErasureReceiptRetainedItem.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get kind => (raw['kind'] as String);
  String get purpose => (raw['purpose'] as String);
}

class VastuArchiveDeleteDataErasureReceipt {
  final Map<String, dynamic> raw;
  VastuArchiveDeleteDataErasureReceipt.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  int get schemaVersion => (raw['schemaVersion'] as int);
  String get propertyId => (raw['propertyId'] as String);
  String get status => (raw['status'] as String);
  String get scope => (raw['scope'] as String);
  String get completedAt => (raw['completedAt'] as String);
  List<VastuArchiveDeleteDataErasureReceiptRemovedItem> get removed => (raw['removed'] as List).map((value0) => VastuArchiveDeleteDataErasureReceiptRemovedItem.fromJson(Map<String, dynamic>.from(value0 as Map))).toList(growable: false);
  List<VastuArchiveDeleteDataErasureReceiptRetainedItem> get retained => (raw['retained'] as List).map((value0) => VastuArchiveDeleteDataErasureReceiptRetainedItem.fromJson(Map<String, dynamic>.from(value0 as Map))).toList(growable: false);
  int get backupRetentionDays => (raw['backupRetentionDays'] as int);
  String get backupPolicy => (raw['backupPolicy'] as String);
  String get hashAlgorithm => (raw['hashAlgorithm'] as String);
  String get receiptHash => (raw['receiptHash'] as String);
  List<String>? get linkedScanIds => raw['linkedScanIds'] == null ? null : (raw['linkedScanIds'] as List).map((value0) => (value0 as String)).toList(growable: false);
  List<String>? get linkedAssessmentIds => raw['linkedAssessmentIds'] == null ? null : (raw['linkedAssessmentIds'] as List).map((value0) => (value0 as String)).toList(growable: false);
  String get deletedByAccountHash => (raw['deletedByAccountHash'] as String);
  int get deletedAtEpoch => (raw['deletedAtEpoch'] as int);
  String? get revisionId => raw['revisionId'] == null ? null : (raw['revisionId'] as String);
}

class VastuPropertiesActivityExportDataEventsItem {
  final Map<String, dynamic> raw;
  VastuPropertiesActivityExportDataEventsItem.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  int get sequence => (raw['sequence'] as int);
  String get actorId => (raw['actorId'] as String);
  String get propertyId => (raw['propertyId'] as String);
  String get revision => (raw['revision'] as String);
  String get contentHash => (raw['contentHash'] as String);
  String get action => (raw['action'] as String);
  int get at => (raw['at'] as int);
  String get previousHash => (raw['previousHash'] as String);
  String get hash => (raw['hash'] as String);
  Map<String, dynamic> get details => Map<String, dynamic>.from(raw['details'] as Map);
}

class VastuPropertiesActivityListDataEventsItem {
  final Map<String, dynamic> raw;
  VastuPropertiesActivityListDataEventsItem.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  int get sequence => (raw['sequence'] as int);
  String get actorId => (raw['actorId'] as String);
  String get propertyId => (raw['propertyId'] as String);
  String get revision => (raw['revision'] as String);
  String get contentHash => (raw['contentHash'] as String);
  String get action => (raw['action'] as String);
  int get at => (raw['at'] as int);
  String get previousHash => (raw['previousHash'] as String);
  String get hash => (raw['hash'] as String);
  Map<String, dynamic> get details => Map<String, dynamic>.from(raw['details'] as Map);
}

class VastuPropertiesCollaborationCommentDataComment {
  final Map<String, dynamic> raw;
  VastuPropertiesCollaborationCommentDataComment.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get id => (raw['id'] as String);
  String get actorId => (raw['actorId'] as String);
  String get assessmentId => (raw['assessmentId'] as String);
  String get revision => (raw['revision'] as String);
  String get contentHash => (raw['contentHash'] as String);
  int get at => (raw['at'] as int);
  String get text => (raw['text'] as String);
}

class VastuPropertiesCollaborationGetDataPropertyIds {
  final Map<String, dynamic> raw;
  VastuPropertiesCollaborationGetDataPropertyIds.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get project => (raw['project'] as String);
  String get building => (raw['building'] as String);
  String get unit => (raw['unit'] as String);
  String get floor => (raw['floor'] as String);
  String get revision => (raw['revision'] as String);
}

class VastuPropertiesCollaborationGetDataPropertyArchiveTier {
  final Map<String, dynamic> raw;
  VastuPropertiesCollaborationGetDataPropertyArchiveTier.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  int get months => (raw['months'] as int);
  int get storedBytes => (raw['storedBytes'] as int);
  int get priceCents => (raw['priceCents'] as int);
  int get setAtEpoch => (raw['setAtEpoch'] as int);
  int get retainUntilEpoch => (raw['retainUntilEpoch'] as int);
}

class VastuPropertiesCollaborationGetDataProperty {
  final Map<String, dynamic> raw;
  VastuPropertiesCollaborationGetDataProperty.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get propertyId => (raw['propertyId'] as String);
  String get ownerId => (raw['ownerId'] as String);
  VastuPropertiesCollaborationGetDataPropertyIds get ids => VastuPropertiesCollaborationGetDataPropertyIds.fromJson(Map<String, dynamic>.from(raw['ids'] as Map));
  String get title => (raw['title'] as String);
  Map<String, dynamic> get data => Map<String, dynamic>.from(raw['data'] as Map);
  int get retentionDays => (raw['retentionDays'] as int);
  int get expiresAtEpoch => (raw['expiresAtEpoch'] as int);
  List<String> get linkedScanIds => (raw['linkedScanIds'] as List).map((value0) => (value0 as String)).toList(growable: false);
  List<String> get linkedAssessmentIds => (raw['linkedAssessmentIds'] as List).map((value0) => (value0 as String)).toList(growable: false);
  VastuPropertiesCollaborationGetDataPropertyArchiveTier? get archiveTier => raw['archiveTier'] == null ? null : VastuPropertiesCollaborationGetDataPropertyArchiveTier.fromJson(Map<String, dynamic>.from(raw['archiveTier'] as Map));
  String? get externalId => raw['externalId'] == null ? null : (raw['externalId'] as String);
  int get createdAtEpoch => (raw['createdAtEpoch'] as int);
  int get updatedAtEpoch => (raw['updatedAtEpoch'] as int);
  String get contentHash => (raw['contentHash'] as String);
}

class VastuPropertiesCollaborationGetDataCommentsItem {
  final Map<String, dynamic> raw;
  VastuPropertiesCollaborationGetDataCommentsItem.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get id => (raw['id'] as String);
  String get actorId => (raw['actorId'] as String);
  String get assessmentId => (raw['assessmentId'] as String);
  String get revision => (raw['revision'] as String);
  String get contentHash => (raw['contentHash'] as String);
  int get at => (raw['at'] as int);
  String get text => (raw['text'] as String);
}

class VastuPropertiesCollaborationGetDataReviewsItem {
  final Map<String, dynamic> raw;
  VastuPropertiesCollaborationGetDataReviewsItem.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get actorId => (raw['actorId'] as String);
  String get assessmentId => (raw['assessmentId'] as String);
  String get revision => (raw['revision'] as String);
  String get contentHash => (raw['contentHash'] as String);
  int get at => (raw['at'] as int);
  String get decision => (raw['decision'] as String);
}

class VastuPropertiesCollaborationReviewDataReview {
  final Map<String, dynamic> raw;
  VastuPropertiesCollaborationReviewDataReview.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get actorId => (raw['actorId'] as String);
  String get assessmentId => (raw['assessmentId'] as String);
  String get revision => (raw['revision'] as String);
  String get contentHash => (raw['contentHash'] as String);
  int get at => (raw['at'] as int);
  String get decision => (raw['decision'] as String);
}

class VastuPropertiesCollaborationUpdateDataPropertyIds {
  final Map<String, dynamic> raw;
  VastuPropertiesCollaborationUpdateDataPropertyIds.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get project => (raw['project'] as String);
  String get building => (raw['building'] as String);
  String get unit => (raw['unit'] as String);
  String get floor => (raw['floor'] as String);
  String get revision => (raw['revision'] as String);
}

class VastuPropertiesCollaborationUpdateDataPropertyArchiveTier {
  final Map<String, dynamic> raw;
  VastuPropertiesCollaborationUpdateDataPropertyArchiveTier.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  int get months => (raw['months'] as int);
  int get storedBytes => (raw['storedBytes'] as int);
  int get priceCents => (raw['priceCents'] as int);
  int get setAtEpoch => (raw['setAtEpoch'] as int);
  int get retainUntilEpoch => (raw['retainUntilEpoch'] as int);
}

class VastuPropertiesCollaborationUpdateDataProperty {
  final Map<String, dynamic> raw;
  VastuPropertiesCollaborationUpdateDataProperty.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get propertyId => (raw['propertyId'] as String);
  String get ownerId => (raw['ownerId'] as String);
  VastuPropertiesCollaborationUpdateDataPropertyIds get ids => VastuPropertiesCollaborationUpdateDataPropertyIds.fromJson(Map<String, dynamic>.from(raw['ids'] as Map));
  String get title => (raw['title'] as String);
  Map<String, dynamic> get data => Map<String, dynamic>.from(raw['data'] as Map);
  int get retentionDays => (raw['retentionDays'] as int);
  int get expiresAtEpoch => (raw['expiresAtEpoch'] as int);
  List<String> get linkedScanIds => (raw['linkedScanIds'] as List).map((value0) => (value0 as String)).toList(growable: false);
  List<String> get linkedAssessmentIds => (raw['linkedAssessmentIds'] as List).map((value0) => (value0 as String)).toList(growable: false);
  VastuPropertiesCollaborationUpdateDataPropertyArchiveTier? get archiveTier => raw['archiveTier'] == null ? null : VastuPropertiesCollaborationUpdateDataPropertyArchiveTier.fromJson(Map<String, dynamic>.from(raw['archiveTier'] as Map));
  String? get externalId => raw['externalId'] == null ? null : (raw['externalId'] as String);
  int get createdAtEpoch => (raw['createdAtEpoch'] as int);
  int get updatedAtEpoch => (raw['updatedAtEpoch'] as int);
  String get contentHash => (raw['contentHash'] as String);
}

class VastuPropertiesDeleteDataErasureReceiptRemovedItem {
  final Map<String, dynamic> raw;
  VastuPropertiesDeleteDataErasureReceiptRemovedItem.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get kind => (raw['kind'] as String);
  String? get recordId => raw['recordId'] == null ? null : (raw['recordId'] as String);
  String? get artifactId => raw['artifactId'] == null ? null : (raw['artifactId'] as String);
  String? get artifactHash => raw['artifactHash'] == null ? null : (raw['artifactHash'] as String);
  String? get versionHash => raw['versionHash'] == null ? null : (raw['versionHash'] as String);
  bool? get deleteMarker => raw['deleteMarker'] == null ? null : (raw['deleteMarker'] as bool);
  int? get versionCount => raw['versionCount'] == null ? null : (raw['versionCount'] as int);
  int? get deleteMarkerCount => raw['deleteMarkerCount'] == null ? null : (raw['deleteMarkerCount'] as int);
  String? get versionsSha256 => raw['versionsSha256'] == null ? null : (raw['versionsSha256'] as String);
}

class VastuPropertiesDeleteDataErasureReceiptRetainedItem {
  final Map<String, dynamic> raw;
  VastuPropertiesDeleteDataErasureReceiptRetainedItem.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get kind => (raw['kind'] as String);
  String get purpose => (raw['purpose'] as String);
}

class VastuPropertiesDeleteDataErasureReceipt {
  final Map<String, dynamic> raw;
  VastuPropertiesDeleteDataErasureReceipt.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  int get schemaVersion => (raw['schemaVersion'] as int);
  String get propertyId => (raw['propertyId'] as String);
  String get status => (raw['status'] as String);
  String get scope => (raw['scope'] as String);
  String get completedAt => (raw['completedAt'] as String);
  List<VastuPropertiesDeleteDataErasureReceiptRemovedItem> get removed => (raw['removed'] as List).map((value0) => VastuPropertiesDeleteDataErasureReceiptRemovedItem.fromJson(Map<String, dynamic>.from(value0 as Map))).toList(growable: false);
  List<VastuPropertiesDeleteDataErasureReceiptRetainedItem> get retained => (raw['retained'] as List).map((value0) => VastuPropertiesDeleteDataErasureReceiptRetainedItem.fromJson(Map<String, dynamic>.from(value0 as Map))).toList(growable: false);
  int get backupRetentionDays => (raw['backupRetentionDays'] as int);
  String get backupPolicy => (raw['backupPolicy'] as String);
  String get hashAlgorithm => (raw['hashAlgorithm'] as String);
  String get receiptHash => (raw['receiptHash'] as String);
  List<String>? get linkedScanIds => raw['linkedScanIds'] == null ? null : (raw['linkedScanIds'] as List).map((value0) => (value0 as String)).toList(growable: false);
  List<String>? get linkedAssessmentIds => raw['linkedAssessmentIds'] == null ? null : (raw['linkedAssessmentIds'] as List).map((value0) => (value0 as String)).toList(growable: false);
  String get deletedByAccountHash => (raw['deletedByAccountHash'] as String);
  int get deletedAtEpoch => (raw['deletedAtEpoch'] as int);
  String? get revisionId => raw['revisionId'] == null ? null : (raw['revisionId'] as String);
}

class VastuArchiveDeleteData {
  final Map<String, dynamic> raw;
  VastuArchiveDeleteData.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String? get rulesVersion => raw['rulesVersion'] == null ? null : (raw['rulesVersion'] as String);
  String get propertyId => (raw['propertyId'] as String);
  bool get deleted => (raw['deleted'] as bool);
  bool get exportDeleted => (raw['exportDeleted'] as bool);
  List<String> get linkedScanIds => (raw['linkedScanIds'] as List).map((value0) => (value0 as String)).toList(growable: false);
  List<String> get linkedAssessmentIds => (raw['linkedAssessmentIds'] as List).map((value0) => (value0 as String)).toList(growable: false);
  String? get erasureStatus => raw['erasureStatus'] == null ? null : (raw['erasureStatus'] as String);
  VastuArchiveDeleteDataErasureReceipt? get erasureReceipt => raw['erasureReceipt'] == null ? null : VastuArchiveDeleteDataErasureReceipt.fromJson(Map<String, dynamic>.from(raw['erasureReceipt'] as Map));
  int? get retryAfterEpoch => raw['retryAfterEpoch'] == null ? null : (raw['retryAfterEpoch'] as int);
  String? get revisionId => raw['revisionId'] == null ? null : (raw['revisionId'] as String);
  bool? get replayed => raw['replayed'] == null ? null : (raw['replayed'] as bool);
}

class VastuPropertiesActivityExportData {
  final Map<String, dynamic> raw;
  VastuPropertiesActivityExportData.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  List<VastuPropertiesActivityExportDataEventsItem> get events => (raw['events'] as List).map((value0) => VastuPropertiesActivityExportDataEventsItem.fromJson(Map<String, dynamic>.from(value0 as Map))).toList(growable: false);
  int? get nextCursor => raw['nextCursor'] == null ? null : (raw['nextCursor'] as int);
  String get format => (raw['format'] as String);
  String get content => (raw['content'] as String);
}

class VastuPropertiesActivityListData {
  final Map<String, dynamic> raw;
  VastuPropertiesActivityListData.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  List<VastuPropertiesActivityListDataEventsItem> get events => (raw['events'] as List).map((value0) => VastuPropertiesActivityListDataEventsItem.fromJson(Map<String, dynamic>.from(value0 as Map))).toList(growable: false);
  int? get nextCursor => raw['nextCursor'] == null ? null : (raw['nextCursor'] as int);
}

class VastuPropertiesCollaborationCommentData {
  final Map<String, dynamic> raw;
  VastuPropertiesCollaborationCommentData.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  VastuPropertiesCollaborationCommentDataComment get comment => VastuPropertiesCollaborationCommentDataComment.fromJson(Map<String, dynamic>.from(raw['comment'] as Map));
}

class VastuPropertiesCollaborationGetData {
  final Map<String, dynamic> raw;
  VastuPropertiesCollaborationGetData.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  VastuPropertiesCollaborationGetDataProperty get property => VastuPropertiesCollaborationGetDataProperty.fromJson(Map<String, dynamic>.from(raw['property'] as Map));
  List<VastuPropertiesCollaborationGetDataCommentsItem> get comments => (raw['comments'] as List).map((value0) => VastuPropertiesCollaborationGetDataCommentsItem.fromJson(Map<String, dynamic>.from(value0 as Map))).toList(growable: false);
  List<VastuPropertiesCollaborationGetDataReviewsItem> get reviews => (raw['reviews'] as List).map((value0) => VastuPropertiesCollaborationGetDataReviewsItem.fromJson(Map<String, dynamic>.from(value0 as Map))).toList(growable: false);
}

class VastuPropertiesCollaborationInviteData {
  final Map<String, dynamic> raw;
  VastuPropertiesCollaborationInviteData.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String get invitationId => (raw['invitationId'] as String);
  String get status => (raw['status'] as String);
}

class VastuPropertiesCollaborationMembersData {
  final Map<String, dynamic> raw;
  VastuPropertiesCollaborationMembersData.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  Map<String, dynamic> get members => Map<String, dynamic>.from(raw['members'] as Map);
}

class VastuPropertiesCollaborationReviewData {
  final Map<String, dynamic> raw;
  VastuPropertiesCollaborationReviewData.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  VastuPropertiesCollaborationReviewDataReview get review => VastuPropertiesCollaborationReviewDataReview.fromJson(Map<String, dynamic>.from(raw['review'] as Map));
}

class VastuPropertiesCollaborationRevokeData {
  final Map<String, dynamic> raw;
  VastuPropertiesCollaborationRevokeData.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String? get accountId => raw['accountId'] == null ? null : (raw['accountId'] as String);
  bool get revoked => (raw['revoked'] as bool);
  String? get invitationId => raw['invitationId'] == null ? null : (raw['invitationId'] as String);
}

class VastuPropertiesCollaborationUpdateData {
  final Map<String, dynamic> raw;
  VastuPropertiesCollaborationUpdateData.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  VastuPropertiesCollaborationUpdateDataProperty get property => VastuPropertiesCollaborationUpdateDataProperty.fromJson(Map<String, dynamic>.from(raw['property'] as Map));
}

class VastuPropertiesDeleteData {
  final Map<String, dynamic> raw;
  VastuPropertiesDeleteData.fromJson(Map<String, dynamic> json) : raw = Map.unmodifiable(json);
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(raw);
  String? get rulesVersion => raw['rulesVersion'] == null ? null : (raw['rulesVersion'] as String);
  String get propertyId => (raw['propertyId'] as String);
  bool get deleted => (raw['deleted'] as bool);
  String? get erasureStatus => raw['erasureStatus'] == null ? null : (raw['erasureStatus'] as String);
  VastuPropertiesDeleteDataErasureReceipt? get erasureReceipt => raw['erasureReceipt'] == null ? null : VastuPropertiesDeleteDataErasureReceipt.fromJson(Map<String, dynamic>.from(raw['erasureReceipt'] as Map));
  int? get retryAfterEpoch => raw['retryAfterEpoch'] == null ? null : (raw['retryAfterEpoch'] as int);
  bool? get exportDeleted => raw['exportDeleted'] == null ? null : (raw['exportDeleted'] as bool);
  List<String>? get linkedScanIds => raw['linkedScanIds'] == null ? null : (raw['linkedScanIds'] as List).map((value0) => (value0 as String)).toList(growable: false);
  List<String>? get linkedAssessmentIds => raw['linkedAssessmentIds'] == null ? null : (raw['linkedAssessmentIds'] as List).map((value0) => (value0 as String)).toList(growable: false);
  String? get revisionId => raw['revisionId'] == null ? null : (raw['revisionId'] as String);
  bool? get replayed => raw['replayed'] == null ? null : (raw['replayed'] as bool);
}
