class VastuRemediationTasksUpsertRequest {
  final int expectedRevision;
  final String mutationId;
  final String propertyId;
  final Map<String, dynamic> task;
  const VastuRemediationTasksUpsertRequest({required this.expectedRevision, required this.mutationId, required this.propertyId, required this.task});
  Map<String, dynamic> toJson() => {
    'expectedRevision': expectedRevision,
    'mutationId': mutationId,
    'propertyId': propertyId,
    'task': task,
  };
}

class VastuRemediationTasksListRequest {
  final String propertyId;
  const VastuRemediationTasksListRequest({required this.propertyId});
  Map<String, dynamic> toJson() => {
    'propertyId': propertyId,
  };
}

class VastuRemediationTasksDeleteRequest {
  final String id;
  final String confirmId;
  const VastuRemediationTasksDeleteRequest({required this.id, required this.confirmId});
  Map<String, dynamic> toJson() => {
    'id': id,
    'confirmId': confirmId,
  };
}

class VastuRemediationReassessRequest {
  final int expectedRevision;
  final String mutationId;
  final String propertyId;
  final String taskId;
  final Map<String, dynamic> plan;
  const VastuRemediationReassessRequest({required this.expectedRevision, required this.mutationId, required this.propertyId, required this.taskId, required this.plan});
  Map<String, dynamic> toJson() => {
    'expectedRevision': expectedRevision,
    'mutationId': mutationId,
    'propertyId': propertyId,
    'taskId': taskId,
    'plan': plan,
  };
}

class VastuMerchantCatalogUploadRequest {
  final int expectedRevision;
  final String mutationId;
  final String catalogId;
  final String format;
  final Object content;
  const VastuMerchantCatalogUploadRequest({required this.expectedRevision, required this.mutationId, required this.catalogId, required this.format, required this.content});
  Map<String, dynamic> toJson() => {
    'expectedRevision': expectedRevision,
    'mutationId': mutationId,
    'catalogId': catalogId,
    'format': format,
    'content': content,
  };
}

class VastuMerchantCatalogGetRequest {
  final String catalogId;
  const VastuMerchantCatalogGetRequest({required this.catalogId});
  Map<String, dynamic> toJson() => {
    'catalogId': catalogId,
  };
}

class VastuMerchantCatalogDeleteRequest {
  final String id;
  final String confirmId;
  const VastuMerchantCatalogDeleteRequest({required this.id, required this.confirmId});
  Map<String, dynamic> toJson() => {
    'id': id,
    'confirmId': confirmId,
  };
}

class VastuMerchantRemediesRequest {
  final String catalogId;
  final List<String> remedyKeys;
  const VastuMerchantRemediesRequest({required this.catalogId, required this.remedyKeys});
  Map<String, dynamic> toJson() => {
    'catalogId': catalogId,
    'remedyKeys': remedyKeys,
  };
}
