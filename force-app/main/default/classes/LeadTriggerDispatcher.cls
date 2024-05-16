public class LeadTriggerDispatcher  implements TriggerDispatcher{
    
    private LeadHelper helper;
    
    public LeadTriggerDispatcher() {
        helper = new LeadHelper();
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
        helper.asignCountryData_before_Insert_Update();
    }
    
    public void beforeUpdate() {
        System.debug('Lead (Before Update)');
        helper.asignCountryData_before_Insert_Update();
    }
    
    public void beforeDelete() {
        System.debug('Lead (Before Delete)');
    }
    
    public void afterInsert() {
        System.debug('Lead (After Insert)');
    }
    
    public void afterUpdate() {
        System.debug('Lead (After Update)');
    }
    
    public void afterDelete() {
        System.debug('Lead (After Delete)');
    }
    
    public void afterUndelete() {
		System.debug('Lead (After Undelete)');
    }
    
    public boolean isEnabled() {
        return Boolean.valueOf(Label.LeadTriggerEnabled);
    }

}