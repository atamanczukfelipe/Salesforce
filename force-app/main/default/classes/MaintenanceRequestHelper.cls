/**
 * @description       : Apex Specialist Superbadge
 * @author            : Felipe Atamanczuk
 * @group             : 
 * @last modified on  : 10-27-2020
 * @last modified by  : Felipe Atamanczuk
 * Modifications Log 
 * Ver   Date         Author              Modification
 * 1.0   10-27-2020   Felipe Atamanczuk   Initial Version
**/
public with sharing class MaintenanceRequestHelper {

    public static List<Case> updatedMaintenanceList ( List<Case> maintenanceRequests){
        return [ SELECT ID, Equipment__r.Maintenance_Cycle__c,Type, Status, Vehicle__c, Subject, Equipment__c  FROM CASE WHERE ID=: maintenanceRequests];
    }
    
    public static void updateWorkOrders( List<Case> maintenanceRequests, Map <Id, Case> mapOldRecords) {
        List<Case> maintenanceRequestsThatMetTheCriteria = new List<Case>();

        //New Maintenance
        List<Case> newMaintenanceListForRoutineCheckup = new List<Case>();

        //Checking for records that meet the criteria
        for (Case maintenanceRequest: updatedMaintenanceList(maintenanceRequests)) {
            Case oldMaintenance = mapOldRecords.get(maintenanceRequest.Id);

            if(meetCriteria(maintenanceRequest, oldMaintenance) && maintenanceRequest.Type == 'Repair' || maintenanceRequest.Type =='Routine Maintenance'){
                maintenanceRequestsThatMetTheCriteria.add(maintenanceRequest);
            }
        }

        //Minimum number of days required to close newest case
        Map <Id, Decimal> mapMaintenanceIdWithCycleDays = retrieveMinimumCycleDays(maintenanceRequestsThatMetTheCriteria);

        for(Case newMaintenanceRequest : maintenanceRequestsThatMetTheCriteria){
            //Create a new routine once the first one is closed, with same vehicle and equipment
            Case routineCheckupMaintenance = new Case();
            routineCheckupMaintenance.Vehicle__c = newMaintenanceRequest.Vehicle__c;
            routineCheckupMaintenance.Equipment__c = newMaintenanceRequest.Equipment__c;
            routineCheckupMaintenance.Type = 'Routin Maintenance';
            routineCheckupMaintenance.Subject = String.isBlank(newMaintenanceRequest.Subject)?'New Routine' : newMaintenanceRequest.Subject;
            routineCheckupMaintenance.Status = 'New';
            routineCheckupMaintenance.Date_Reported__c = System.today();
            if (mapMaintenanceIdWithCycleDays.containsKey(newMaintenanceRequest.Id)) {
                routineCheckupMaintenance.Date_Due__c = System.today().addDays((Integer) mapMaintenanceIdWithCycleDays.get(newMaintenanceRequest.Id));
            }else {
                routineCheckupMaintenance.Date_Due__c = System.today().addDays((Integer) newMaintenanceRequest.Equipment__r.Maintenance_Cycle__c);
            }
            routineCheckupMaintenance.Old_Case__c = newMaintenanceRequest.Id;
            //Add to the list
            newMaintenanceListForRoutineCheckup.add(routineCheckupMaintenance);
        }
        //insert the list 
        insert newMaintenanceListForRoutineCheckup;
        updateRelatedWorkParts( newMaintenanceListForRoutineCheckup);
    }

    //New maintence records are created, update the work parts
    public static void updateRelatedParts (List<Case> createdMaintenances){
        Map<Id, Id> mapNewMaintenancesWithClosedMaintenances = new Map<Id,Id> ();
        for(Case newMaintenances : createdMaintenances){
            mapNewMaintenancesWithClosedMaintenances.put(newMaintenances.Old_Case__c, newMaintenances.Id);
        }

    }
    
}