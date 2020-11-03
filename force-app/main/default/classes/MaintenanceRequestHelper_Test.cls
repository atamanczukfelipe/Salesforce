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
@isTest
public class MaintenanceRequestHelper_Test{
    static List<Case> caseLst = new List<Case> ();
    static List<Product2> prodLst = new List<Product2> ();
    static List<Work_Part__c> workpartLst = new List<Work_Part__c> ();

    @TestSetup
    static void getData(){
        caseLst = CreateData( 300,3,3,'Repair');
        
    }
}