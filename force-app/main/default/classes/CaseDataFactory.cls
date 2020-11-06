/**
 * @description       : Apex Specialist Superbadge
 * @author            : Felipe Atamanczuk
 * @group             : 
 * @last modified on  : 11-06-2020
 * @last modified by  : Felipe Atamanczuk
 * Modifications Log 
 * Ver   Date         Author              Modification
 * 1.0   11-04-2020   Felipe Atamanczuk   Initial Version
**/
public with sharing class CaseDataFactory {
    public static List<Case> createCasePositive (Integer numbOfCase, Integer numbOfProd){
            List<Case> lstCase = new List<Case>();
            List<Product2> prodLst = new List<Product2> ();
            //Case
            for (Integer i=0; i<numbOfCase; i++) {
                Case newCase = new Case();
                newCase.Status = 'New';
                newCase.Origin = 'Phone';
                lstCase.add(newCase);
            }
            for (Integer i=0;i<numbOfProd;i++) {
                Product2 prod = new Product2 ();
                prod.Name = 'Test Product ' + i;
                if (i!=0) {
                    prod.Maintenance_Cycle__c = i;
                    prod.Replacement_Part__c = true;
                    prodLst.add(prod);
                }
            }
            upsert prodLst;
            return lstCase;
    }
}
