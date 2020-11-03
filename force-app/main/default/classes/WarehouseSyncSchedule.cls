/**
 * @description       : Apex Specialist Superbadge
 * @author            : Felipe Atamanczuk
 * @group             : 
 * @last modified on  : 11-03-2020
 * @last modified by  : Felipe Atamanczuk
 * Modifications Log 
 * Ver   Date         Author              Modification
 * 1.0   11-03-2020   Felipe Atamanczuk   Initial Version
**/
global class WarehouseSyncSchedule implements Schedulable {
    global void execute(SchedulableContext ctx){
        //You need to update Salesforce data during off hours (at 1:00 AM PST)
        WarehouseCalloutService.runWarehouseEquipmentSync();
    }
}