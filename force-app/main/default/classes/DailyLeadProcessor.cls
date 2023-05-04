public class DailyLeadProcessor implements Schedulable {

    public void execute(SchedulableContext ctx) {

        //Get 200 Lead records and modify the LeadSource field
        List<Lead> leads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = null LIMIT 200];

        for (Lead lead : leads) {
            lead.LeadSource = 'Dreamforce';
        }

        //Update the modified records
        update leads;
    }
}