public class CountryTriggerDispatcher  implements TriggerDispatcher{
    
    private CountryHelper helper;
    
    public CountryTriggerDispatcher() {
        helper = new CountryHelper();
    }
    
    public void bulkBefore() {
        System.debug('Lead (Bulk Before)');
    }
    
    public void bulkAfter() {
        System.debug('Lead (Bulk After)');
    }
    
    public void andFinally() {
        System.debug('Lead (Finally)');
    }
    
    public void beforeInsert() {
        System.debug('Lead (Before Insert)');
    }
    
    public void beforeUpdate() {
        System.debug('Lead (Before Update)');
    }
    
    public void beforeDelete() {
        System.debug('Lead (Before Delete)');
    }
    
    public void afterInsert() {
        System.debug('Lead (After Insert)');
        helper.updateLeadsCountry_After_Insert_Update();
    }
    
    public void afterUpdate() {
        System.debug('Lead (After Update)');
        helper.updateLeadsCountry_After_Insert_Update();
    }
    
    public void afterDelete() {
        System.debug('Lead (After Delete)');
    }
    
    public void afterUndelete() {
		System.debug('Lead (After Undelete)');
    }
    
    public boolean isEnabled() {
        return Boolean.valueOf(Label.CountryTriggerEnabled);
    }

}