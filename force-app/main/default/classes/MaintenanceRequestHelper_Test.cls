/**
 * @description       : Apex Specialist Superbadge
 * @author            : Felipe Atamanczuk
 * @group             : 
 * @last modified on  : 11-06-2020
 * @last modified by  : Felipe Atamanczuk
 * Modifications Log 
 * Ver   Date         Author              Modification
 * 1.0   11-03-2020   Felipe Atamanczuk   Initial Version
**/
@isTest
public class MaintenanceRequestHelper_Test{
    @isTest
    public static void caseTrigger_positiveCase(){
        //criar dado, inserir, modificar, update
        Case[] c = CaseDataFactory.createCasePositive(1,10);
        insert c;
        Test.startTest();
        //aqui fazer alteração
        c[0].Status = 'Closed';
        c[0].Type = 'Repair';

        update c;

        Test.stopTest();
        List<Case> testcase = [SELECT Id FROM Case WHERE Type =: 'Routine Maintenance'];

        System.assertEquals(1, testcase.size());
    }  
}