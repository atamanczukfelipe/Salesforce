/**
 * @description       : Apex Specialist Superbadge
 * @author            : Felipe Atamanczuk
 * @group             : 
 * @last modified on  : 10-30-2020
 * @last modified by  : Felipe Atamanczuk
 * Modifications Log 
 * Ver   Date         Author              Modification
 * 1.0   10-30-2020   Felipe Atamanczuk   Initial Version
**/
public with sharing class DTOCallout {
        public String extId {get; set;} //extId equals _id from JSON
        public Boolean replacement {get; set;}
        public Integer quantity {get; set;}
        public String name {get; set;}
        public Integer maintenanceperiod {get; set;}
        public Integer lifespan {get; set;}
        public Decimal cost {get; set;}
        public Integer sku {get; set;}
        public DTOCallout(){
                
        }
}