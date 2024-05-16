@isTest
public class CountryAPI_Test {

    @isTest
    static void upsertCountries_test() {
        
        Test.setMock(HttpCalloutMock.class, new CountryAPIMockCallout());
        
        country__c pais =new country__C();
        pais.name='España';
        pais.alpha_2_code__c='ES';
        insert pais;
        
        test.startTest();

        CountryAPIUpdate.upsertCountries();
        
        List<Country__c> countries = [SELECT id,name,alpha_2_code__c FROM Country__c];
        System.assertEquals(2, countries.size());
        for(country__c con :countries){
            if(con.name=='España'){
                System.assertEquals('ES', con.alpha_2_code__c);
            }else{
                System.assertEquals('PT', con.alpha_2_code__c);
            }
        }
        
        test.stopTest();
    }
}