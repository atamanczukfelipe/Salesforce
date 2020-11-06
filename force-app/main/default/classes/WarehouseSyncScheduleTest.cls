/**
 * @description       : Apex Specialist Superbadge
 * @author            : Felipe Atamanczuk
 * @group             : 
 * @last modified on  : 11-06-2020
 * @last modified by  : Felipe Atamanczuk
 * Modifications Log 
 * Ver   Date         Author              Modification
 * 1.0   11-06-2020   Felipe Atamanczuk   Initial Version
**/
@isTest
public with sharing class WarehouseSyncScheduleTest {
    //Dummy CRON expression
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    @isTest 
    static void testScheduledJob(){
        //Create Data
        CaseDataFactory.createCasePositive(5, 2);
        Test.startTest();
        //Mock Callout
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
        String jobId = System.schedule('TestScheduleJob', CRON_EXP, new WarehouseSyncSchedule());
        Test.stopTest();
    }
    public WarehouseSyncScheduleTest() {

    }
}
/**@isTest
private class WarehouseSyncScheduleTest {
    //Dummy CRON expression
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    @isTest 
    static void testScheduledJob(){
        //call the MaintenanceRequestTest class with method CreateData
         MaintenanceRequestTest.CreateData( 5,2,2,'Repair');
        Test.startTest();
        //implements the mock callout 
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
        String joBID= System.schedule('TestScheduleJob', CRON_EXP, new WarehouseSyncSchedule());
       // List<Case> caselist = [Select count(id) from case where case]        
        Test.stopTest();
    }
} */

/**
 * Trailhead Example
 * 
 * @isTest
private class RemindOppyOwnersTest {
    // Dummy CRON expression: midnight on March 15.
    // Because this is a test, job executes
    // immediately after Test.stopTest().
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    static testmethod void testScheduledJob() {
        // Create some out of date Opportunity records
        List<Opportunity> opptys = new List<Opportunity>();
        Date closeDate = Date.today().addDays(-7);
        for (Integer i=0; i<10; i++) {
            Opportunity o = new Opportunity(
                Name = 'Opportunity ' + i,
                CloseDate = closeDate,
                StageName = 'Prospecting'
            );
            opptys.add(o);
        }
        insert opptys;
        // Get the IDs of the opportunities we just inserted
        Map<Id, Opportunity> opptyMap = new Map<Id, Opportunity>(opptys);
        List<Id> opptyIds = new List<Id>(opptyMap.keySet());
        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP,
            new RemindOpptyOwners());
        // Verify the scheduled job has not run yet.
        List<Task> lt = [SELECT Id
            FROM Task
            WHERE WhatId IN :opptyIds];
        System.assertEquals(0, lt.size(), 'Tasks exist before job has run');
        // Stopping the test will run the job synchronously
        Test.stopTest();
        // Now that the scheduled job has executed,
        // check that our tasks were created
        lt = [SELECT Id
            FROM Task
            WHERE WhatId IN :opptyIds];
        System.assertEquals(opptyIds.size(),
            lt.size(),
            'Tasks were not created');
    }
}
 */