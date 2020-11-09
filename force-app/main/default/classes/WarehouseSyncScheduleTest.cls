/**
 * @description       : Apex Specialist Superbadge
 * @author            : Felipe Atamanczuk
 * @group             : 
 * @last modified on  : 11-09-2020
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