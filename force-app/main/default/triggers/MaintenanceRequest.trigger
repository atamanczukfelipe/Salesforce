/**
 * @description       : Apex Specialist Superbadge
 * @author            : Felipe Atamanczuk
 * @group             : 
 * @last modified on  : 10-28-2020
 * @last modified by  : Felipe Atamanczuk
 * Modifications Log 
 * Ver   Date         Author              Modification
 * 1.0   10-27-2020   Felipe Atamanczuk   Initial Version
**/
trigger MaintenanceRequest on Case (before update, after update) {
    Map<Id,Case> caseList = new Map<Id,Case>();
    if(Trigger.isUpdate && Trigger.isAfter){
        for (Case oCase : Trigger.new) {
            //create a trigger handler later on to put all this code
            if (oCase.IsClosed && (oCase.Type.equals('Repair') || oCase.Type.equals('Routine Maintenance'))) {
                caseList.put(oCase.Id, oCase);
            }
            if (caseList.size() >0) {
                MaintenanceRequestHelper.updateWorkOrders(caseList);
            }
        }
    }
}