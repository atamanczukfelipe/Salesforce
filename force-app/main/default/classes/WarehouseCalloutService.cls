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

        //checking the response code, to see if its equals 200, if true everything is ok
        if (httpresponse.getStatusCode() == 200) {
            //Deserializes the specified JSON string into collections of primitive data types.
            stringmsg = httpresponse.getBody();
            List<String> deserializeResults = (List<String>.class) JSON.deserialize(stringmsg, List<String>.class);
            
            //List<Customer> deserializeResults = (List<Customer>.class) JSON.deserialize(response, List<Customer>.class);

        }

        //example from trailhead using @future callout
        /**public static void sendSMSAsync(String fromNbr, String toNbr, String m) {
            String results = sendSMS(fromNbr, toNbr, m);
            System.debug(results);
        }      
        //ToDo: complete this method to make the callout (using @future) to the
        //      REST endpoint and update equipment on hand.**/ 
                
    }
}