@isTest
public class LeadTriggerTest {
@isTest
    static void leadstrigger_test(){
        
        country__c pais = new country__c();
        pais.name='España';
        pais.alpha_2_code__c='ES';
        insert pais;
        
        country__c pais2 = new country__c();
        pais2.name='Portugal';
        pais2.alpha_2_code__c='PT';
        insert pais2;
        
        test.startTest();
        Lead cad = new lead();
        cad.FirstName='test';
        cad.LastName='1';
        cad.country='España';
        cad.Company='Viseo';
        insert cad;
        
        Lead ld = [select name,alpha_2_code__c from lead limit 1];
        system.assertEquals('ES',ld.alpha_2_code__c);
        
        cad.country='Portugal';
        update cad;
        
        Lead ld2 = [select name,alpha_2_code__c from lead limit 1];
        system.assertEquals('PT',ld2.alpha_2_code__c);
        
        delete ld2;
        test.stopTest();
    }
}