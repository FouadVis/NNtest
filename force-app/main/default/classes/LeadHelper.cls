public class LeadHelper {
    
    private List<Lead> oldList; 
    private List<Lead> newList; 
    private Map<id, Lead> oldMap;
    private Map<id, Lead> newMap;
    
    public LeadHelper() {
        this.oldList = Trigger.old;
        this.newList = Trigger.new;
        this.oldMap = (Map<id, Lead>) Trigger.oldMap;
        this.newMap = (Map<id, Lead>) Trigger.newMap;
    }
    
    public void asignCountryData_before_Insert_Update(){
        set<string> countries = new set<string>();
        set<id> leadsAffected = new set<id>();
        for(Lead ld:newList){
            if(trigger.isInsert && ld.Country!=null){
                countries.add(ld.country);
                leadsAffected.add(ld.id);
            }else if(trigger.isUpdate){
                if(ld.Country!=null && ld.country!=oldMap.get(ld.id).country){
                    countries.add(ld.Country);
                    leadsAffected.add(ld.id);
                } 
            }
        }
        if(countries.size()>0){
            list<country__c> countriesDataList = [select id,name,alpha_2_code__c,alpha_3_code__c,Capital_city__c,region__c,subregion__c from country__c where name in :countries];
            map<string, country__c> countriesDataMap = new map<string,country__c>();
            for(country__c con :countriesDataList){
                countriesDataMap.put(con.name,con);
            }
            for(Lead ld:newList){
                if(leadsAffected.contains(ld.id)) if(countriesDataMap.get(ld.Country)!=null){
                    ld.alpha_2_code__c=countriesDataMap.get(ld.Country).alpha_2_code__c;
                    ld.alpha_3_code__c=countriesDataMap.get(ld.Country).alpha_3_code__c;
                    ld.Capital_city__c=countriesDataMap.get(ld.Country).Capital_city__c;
                    ld.region__c=countriesDataMap.get(ld.Country).region__c;
                    ld.subregion__c=countriesDataMap.get(ld.Country).subregion__c;
                }
            }
        }
    }

}