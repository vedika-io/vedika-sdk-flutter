class VastuPropertiesCollaborationGetRequest {
  final String propertyId;
  final String? ownerId;
  const VastuPropertiesCollaborationGetRequest({required this.propertyId, this.ownerId});
  Map<String, dynamic> toJson() => {
    'propertyId': propertyId,
    if (ownerId != null) 'ownerId': ownerId,
  };
}

class VastuPropertiesCollaborationInviteRequest {
  final String propertyId;
  final String? ownerId;
  final String? accountId;
  final String? email;
  final String role;
  final bool? accept;
  const VastuPropertiesCollaborationInviteRequest({required this.propertyId, this.ownerId, this.accountId, this.email, required this.role, this.accept});
  Map<String, dynamic> toJson() => {
    'propertyId': propertyId,
    if (ownerId != null) 'ownerId': ownerId,
    if (accountId != null) 'accountId': accountId,
    if (email != null) 'email': email,
    'role': role,
    if (accept != null) 'accept': accept,
  };
}

class VastuPropertiesCollaborationRevokeRequest {
  final String propertyId;
  final String? ownerId;
  final String? accountId;
  final String? invitationId;
  const VastuPropertiesCollaborationRevokeRequest({required this.propertyId, this.ownerId, this.accountId, this.invitationId});
  Map<String, dynamic> toJson() => {
    'propertyId': propertyId,
    if (ownerId != null) 'ownerId': ownerId,
    if (accountId != null) 'accountId': accountId,
    if (invitationId != null) 'invitationId': invitationId,
  };
}

class VastuPropertiesCollaborationMembersRequest {
  final String propertyId;
  final String? ownerId;
  const VastuPropertiesCollaborationMembersRequest({required this.propertyId, this.ownerId});
  Map<String, dynamic> toJson() => {
    'propertyId': propertyId,
    if (ownerId != null) 'ownerId': ownerId,
  };
}

class VastuPropertiesCollaborationCommentRequest {
  final String propertyId;
  final String? ownerId;
  final String assessmentId;
  final String revision;
  final String expectedContentHash;
  final String text;
  const VastuPropertiesCollaborationCommentRequest({required this.propertyId, this.ownerId, required this.assessmentId, required this.revision, required this.expectedContentHash, required this.text});
  Map<String, dynamic> toJson() => {
    'propertyId': propertyId,
    if (ownerId != null) 'ownerId': ownerId,
    'assessmentId': assessmentId,
    'revision': revision,
    'expectedContentHash': expectedContentHash,
    'text': text,
  };
}

class VastuPropertiesCollaborationReviewRequest {
  final String propertyId;
  final String? ownerId;
  final String assessmentId;
  final String revision;
  final String expectedContentHash;
  final String decision;
  const VastuPropertiesCollaborationReviewRequest({required this.propertyId, this.ownerId, required this.assessmentId, required this.revision, required this.expectedContentHash, required this.decision});
  Map<String, dynamic> toJson() => {
    'propertyId': propertyId,
    if (ownerId != null) 'ownerId': ownerId,
    'assessmentId': assessmentId,
    'revision': revision,
    'expectedContentHash': expectedContentHash,
    'decision': decision,
  };
}

class VastuPropertiesCollaborationUpdateRequest {
  final String propertyId;
  final String? ownerId;
  final String revision;
  final String expectedContentHash;
  final String title;
  final Map<String, dynamic> data;
  const VastuPropertiesCollaborationUpdateRequest({required this.propertyId, this.ownerId, required this.revision, required this.expectedContentHash, required this.title, required this.data});
  Map<String, dynamic> toJson() => {
    'propertyId': propertyId,
    if (ownerId != null) 'ownerId': ownerId,
    'revision': revision,
    'expectedContentHash': expectedContentHash,
    'title': title,
    'data': data,
  };
}

class VastuPropertiesActivityListRequest {
  final String propertyId;
  final String? ownerId;
  final int? cursor;
  final int? limit;
  const VastuPropertiesActivityListRequest({required this.propertyId, this.ownerId, this.cursor, this.limit});
  Map<String, dynamic> toJson() => {
    'propertyId': propertyId,
    if (ownerId != null) 'ownerId': ownerId,
    if (cursor != null) 'cursor': cursor,
    if (limit != null) 'limit': limit,
  };
}

class VastuPropertiesActivityExportRequest {
  final String propertyId;
  final String? ownerId;
  final int? cursor;
  final int? limit;
  const VastuPropertiesActivityExportRequest({required this.propertyId, this.ownerId, this.cursor, this.limit});
  Map<String, dynamic> toJson() => {
    'propertyId': propertyId,
    if (ownerId != null) 'ownerId': ownerId,
    if (cursor != null) 'cursor': cursor,
    if (limit != null) 'limit': limit,
  };
}

class VastuPropertiesDeleteRequest {
  final String propertyId;
  const VastuPropertiesDeleteRequest({required this.propertyId});
  Map<String, dynamic> toJson() => {
    'propertyId': propertyId,
  };
}
