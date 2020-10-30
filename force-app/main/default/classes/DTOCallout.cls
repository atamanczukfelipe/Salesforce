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
    public DTOCallout() {
        public String id;
        public Boolean replacement;
        public Integer quantity;
        public String name;
        public Integer maintenanceperiod;
        public Integer lifespan;
        public Decimal cost;
        public Integer sku;
    }
}
