public class CountryHelper {
    
    private List<Country__c> oldList; 
    private List<Country__c> newList; 
    private Map<id, Country__c> oldMap;
    private Map<id, Country__c> newMap;
    public class CountryHelperException extends Exception {}
    public Schema.SObjectField[] fieldCheck = new Schema.SObjectField[]{Country__c.name,Country__c.alpha_2_code__c,Country__c.alpha_3_code__c,
        Country__c.Capital_city__c,Country__c.region__c,Country__c.subregion__c};
    
    public CountryHelper() {
        this.oldList = Trigger.old;
        this.newList = Trigger.new;
        this.oldMap = (Map<id, Country__c>) Trigger.oldMap;
        this.newMap = (Map<id, Country__c>) Trigger.newMap;
    }
    
    
    public void updateLeadsCountry_After_Insert_Update(){
        map<string,country__c> countriesChanged = new map<string,country__c>();
        for(country__c nl:newList){
            if(trigger.isInsert){
                countriesChanged.put(nl.name,nl);
            }
            else{
                for(Schema.SObjectField field:fieldCheck){
                    if(nl.get(field)!=oldMap.get(nl.Id).get(field)) countriesChanged.put(nl.name,nl);
                }
            } 
        }
        if(countriesChanged.keySet().size()>0){
            List<lead> leadsToChange = [select id,country,alpha_2_code__c,alpha_3_code__c,Capital_city__c,region__c,subregion__c from lead where country in:countriesChanged.keySet()];
            
            if(leadsToChange.size()>0){
                list<lead> updtLead = new list<lead>();
                for(lead ld:leadsToChange){
                    ld.alpha_2_code__c=countriesChanged.get(ld.Country).alpha_2_code__c;
                    ld.alpha_3_code__c=countriesChanged.get(ld.Country).alpha_3_code__c;
                    ld.Capital_city__c=countriesChanged.get(ld.Country).Capital_city__c;
                    ld.region__c=countriesChanged.get(ld.Country).region__c;
                    ld.subregion__c=countriesChanged.get(ld.Country).subregion__c;
                    updtLead.add(ld);
                }
                if(updtLead.size()>0) database.update(updtLead);
            }
            
        }
        
    }


}