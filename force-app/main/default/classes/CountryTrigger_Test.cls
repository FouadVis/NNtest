@isTest
public class CountryTrigger_Test {

    @isTest
    static void countriestrigger_test(){
       
        country__c pais = new country__c();
        pais.name='España';
        pais.alpha_2_code__c='ES';
        pais.alpha_3_code__c='ES';
        insert pais;
        
        Lead cad = new lead();
        cad.FirstName='test';
        cad.LastName='1';
        cad.country='España';
        cad.Company='Viseo';
        insert cad;
        
        Lead cad2 = new lead();
        cad2.FirstName='test';
        cad2.LastName='1';
        cad2.country='Portugal';
        cad2.Company='Viseo';
        insert cad2;
        
        test.startTest();
        country__c pais2 = new country__c();
        pais2.name='Portugal';
        pais2.alpha_2_code__c='PT';
        insert pais2;
        
        Lead ld = [select name,alpha_2_code__c from lead where country='Portugal' limit 1];
        system.assertEquals('PT',ld.alpha_2_code__c);
        
        pais.alpha_3_code__c='ESP';
        update pais;
        
        Lead ld2 = [select name,alpha_3_code__c from lead where country='España' limit 1];
        system.assertEquals('ESP',ld2.alpha_3_code__c);
        
        cad.country='Portugal';
        update cad;
        
        delete pais;
        test.stopTest();
    
    }
}