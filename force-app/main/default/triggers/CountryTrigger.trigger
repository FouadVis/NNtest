trigger CountryTrigger on Country__c (before insert, after insert, 
                                   before update, after update, 
                                   before delete, after delete, 
                                   after undelete) {
    TriggerFactory.createTriggerDispatcher(Country__c.sObjectType);
}