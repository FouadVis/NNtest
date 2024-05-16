public class CountryAPISchedulable implements Schedulable,Database.AllowsCallouts  {
    
    public void execute(SchedulableContext context) {
        CountryAPIUpdate.upsertCountries();
    }
}