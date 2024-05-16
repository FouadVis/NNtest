public class CountryAPIUpdate {
    public static void upsertCountries() {
        try {
           
            HttpRequest req = new HttpRequest();
            req.setEndpoint('http://api.countrylayer.com/v2/all?access_key=954be5dfeabad0569bf244f7e1dc9784');
            req.setMethod('GET');
            req.setHeader('Content-Type', 'application/json');
            
            Http http = new Http();
            HttpResponse response = http.send(req);
            
            System.debug('Body===' + response.getBody());
            if (response.getStatusCode() == 200) {
                String responseBody=response.getBody();
                List<Object> countriesResponse = (List<Object>) JSON.deserializeUntyped(responseBody);
                
                Set<String> countries = new Set<String>();
                for (Object count :countriesResponse) {
                    Map<String, Object> countryMap = (Map<String, Object>) count;
                    countries.add((String) countryMap.get('name'));
                }
                
                List<Country__c> countriesList = [SELECT id,name,alpha_2_code__c,alpha_3_code__c,Capital_city__c,region__c,subregion__c FROM Country__c WHERE name in:countries];
                
				Map<String, Country__c> countriesMap = new Map<String, Country__c>();
                for (Country__c country : countriesList) {
                    countriesMap.put(country.name, country);
                }
                
                List<country__c> upsrtCountries = new list<country__c>();
                for (Object count : countriesResponse) {
                    Map<String, Object> countryMap = (Map<String, Object>) count;
                    Country__c upsrtcountry = new country__c();
                    if(countriesMap.get((String) countryMap.get('name'))!=null){
                        upsrtcountry.id=countriesMap.get((String) countryMap.get('name')).Id;
                    } else{
                        upsrtcountry.Name = (String) countryMap.get('name');
                    }
                    upsrtcountry.alpha_2_code__c = (String) countryMap.get('alpha2Code');
                    upsrtcountry.alpha_3_code__c = (String) countryMap.get('alpha3Code');
                    upsrtcountry.Capital_city__c = (String) countryMap.get('capital');
                    upsrtcountry.region__c = (String) countryMap.get('region');
                    upsrtcountry.subregion__c = (String) countryMap.get('subregion');
                    upsrtCountries.add(upsrtcountry);
                }
                
                
                if(upsrtCountries.size()>0) {
                    database.upsert(upsrtCountries);
                }
                        
            } else {
                System.debug('Status===' + response.getStatusCode());
                System.debug('Body===' + response.getBody());
            }
        }catch (Exception ex) {
            System.debug(ex.getMessage());
        }
        
    }
    
}