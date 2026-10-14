/// Immutable rule-version comparison and signed receipt contracts.
class VastuRuleComparison {
  final Map<String, dynamic> raw;
  VastuRuleComparison.fromJson(this.raw);
  bool get changed => raw['changed'] as bool;
  String get fromVersion => raw['fromVersion'] as String;
  String get toVersion => raw['toVersion'] as String;
  List<Map<String, dynamic>> get changes => (raw['changes'] as List).map((e) => Map<String, dynamic>.from(e as Map)).toList();
}
class VastuReceiptVerification {
  final Map<String, dynamic> raw;
  VastuReceiptVerification.fromJson(this.raw);
  bool get valid => raw['valid'] as bool;
  bool? get inputMatched => raw['inputMatched'] as bool?;
  Map<String, dynamic> get receipt => Map<String, dynamic>.from(raw['receipt'] as Map);
}
class VastuRuleVersions {
  final Map<String, dynamic> raw;
  VastuRuleVersions.fromJson(this.raw);
  String get currentVersion => raw['currentVersion'] as String;
  int get retainedVersions => raw['retainedVersions'] as int;
  List<String> get versions => List<String>.from(raw['versions'] as List);
}
