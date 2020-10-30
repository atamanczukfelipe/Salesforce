/**
 * @description       : Apex Specialist Superbadge
 * @author            : Felipe Atamanczuk
 * @group             : 
 * @last modified on  : 10-30-2020
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
        
            
            System.debug('~~' +recived);
            
            //List<Customer> deserializeResults = (List<Customer>.class) JSON.deserialize(response, List<Customer>.class);

        }      
        //ToDo: complete this method to make the callout (using @future) to the
        //      REST endpoint and update equipment on hand.**/ 
                
    }
}