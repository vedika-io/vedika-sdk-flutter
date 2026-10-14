// Standalone, dependency-free wire-contract check: dart --enable-asserts test/vastu_workflow_model_contract.dart
import '../lib/src/models/common.dart';
import '../lib/src/models/vastu_workflow.dart';
void main() {
 final response=VedikaResponse<VastuWorkflowData>.fromJson({
  'success':true,'billing':{'charged':'0.01','currency':'USD'},
  'data':{'revision':1,'data':{'tasks':{'kitchen':{
   'taskId':'kitchen','reportRef':'report-1','findingRef':'/remedies/0',
   'remedyKey':'vastu.remedy.zone.NE','title':'Record the kitchen work','status':'completed',
   'evidence':[{'reference':'completion-note','photoRef':'synthetic-photo'}]
  }}}}},(data)=>VastuWorkflowData.fromJson(Map<String,dynamic>.from(data as Map)));
 assert(response.billing!.charged==0.01);
 assert(response.data!.revision==1);
 final VastuRemediationTaskData task=response.data!.data!.tasks!['kitchen']!;
 assert(task.status=='completed');assert(task.evidence![0].photoRef=='synthetic-photo');
 assert(BillingInfo.fromJson({'charged':0}).charged==0);
 print('PASS workflow typed task map and native decimal billing');
}
