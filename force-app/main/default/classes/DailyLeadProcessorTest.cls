@isTest
public class DailyLeadProcessorTest {

    private static String CRON_EXP = '0 0 0 ? * * *'; // Midnight every day
    
    @isTest
    private static void testSchedulableClass() {

        // Load test data
        List<Lead> leads = new List<Lead>();
        for(Integer i = 0; i < 500; i++) {
            if (i < 250) {
                leads.add(new Lead(LastName='Hogaboam', Company='Racktime'));
            } else {
                leads.add(new Lead(LastName='Hogaboam', Company='Racktime', LeadSource='Other'));
            }
        }
        insert leads;

        // Perform the test
        Test.startTest();
        String jobId = System.schedule('Process Leads', CRON_EXP, new DailyLeadProcessor());
        Test.stopTest();

        // Check the result
        List<Lead> updatedLeads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(200, updatedLeads.size(), 'ERROR: At least 1 record was not updated properly');

        // Check the scheduled time
        List<CronTrigger> cts = [SELECT Id, TimesTriggered, NextFireTime FROM CronTrigger WHERE Id = :jobId];
        System.debug('Next Fire Time ' + cts[0].NextFireTime);
    }
}