/**
 * @description       : Apex Specialist Superbadge
 * @author            : Felipe Atamanczuk
 * @group             : 
 * @last modified on  : 11-03-2020
 * @last modified by  : Felipe Atamanczuk
 * Modifications Log 
 * Ver   Date         Author              Modification
 * 1.0   10-27-2020   Felipe Atamanczuk   Initial Version
**/
public with sharing class WarehouseCalloutService {

    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';

    @future (callout=true)    
    public static void runWarehouseEquipmentSync() {
        //First create a new HTTP request
        Http http = new Http();
        HttpRequest httpreq = new HttpRequest();
        httpreq.setEndpoint(WAREHOUSE_URL);
        httpreq.setMethod('GET');
        HttpResponse httpresponse = http.send(httpreq);
        DTOCallout dtocall = new DTOCallout();
        String newbody;
       
        //checking the response code, to see if its equals 200, if true everything is ok
        if (httpresponse.getStatusCode() == 200) {
            //Deserializes the specified JSON string into collections of primitive data types.
            newbody = httpresponse.getBody().replace('_id', 'extId');
            List<DTOCallout> recived = (List<DTOCallout>) JSON.deserialize(newbody, List<DTOCallout>.class);
            
            List<Product2> lstEquipmentUp = new List<Product2> ();
            for (DTOCallout iEquipment : recived) {
                Product2 prod = new Product2 ();
                prod.ProductCode = iEquipment.extId;
                prod.Replacement_Part__c = iEquipment.replacement;
                prod.Current_Inventory__c = iEquipment.quantity;
                prod.Name = iEquipment.name;
                prod.Maintenance_Cycle__c = iEquipment.maintenanceperiod;
                prod.Lifespan_Months__c = iEquipment.lifespan;
                prod.Cost__c = iEquipment.cost;
                prod.Warehouse_SKU__c = iEquipment.sku;
                lstEquipmentUp.add(prod);
            }
            if (lstEquipmentUp.size() > 0) {
                upsert lstEquipmentUp; //upsert ->upadate or create records
            }
        }      
    }
}