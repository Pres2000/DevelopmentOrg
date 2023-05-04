public without sharing class MaintenanceRequestTriggerHandler implements TriggerHandler {

    private boolean triggerIsExecuting;
    private integer triggerSize;
    public MaintenanceRequestTriggerHelper helper;

    public MaintenanceRequestTriggerHandler(boolean triggerIsExecuting, integer triggerSize) {
        this.triggerIsExecuting = triggerIsExecuting;
        this.triggerSize = triggerSize;
        this.helper = new MaintenanceRequestTriggerHelper();
    }

    public void beforeInsert(List<Case> newCases) {
        // helper.doTask1();
        // helper.doTask2();
    }

    public void beforeUpdate(List<Case> oldCases, List<Case> newCases, Map<ID, SObject> oldCaseMap, Map<ID, SObject> newCaseMap) {
        helper.updateMaintenanceRequests(newCases, oldCaseMap);
        // helper.doTask4();
    }

    public void beforeDelete(List<Case> oldCases, Map<ID, SObject> oldCaseMap) {
        // helper.doTask5();
        // helper.doTask1();
    }

    public void afterInsert(List<Case> newCases, Map<ID, SObject> newCaseMap) {
        // helper.doTask2();
        // helper.doTask3();
    }

    public void afterUpdate(List<Case> oldCases, List<Case> newCases, Map<ID, SObject> oldCaseMap, Map<ID, SObject> newCaseMap) {
        // helper.doTask4();
        // helper.doTask5();
    }

    public void afterDelete(List<Case> oldCases, Map<ID, SObject> oldCaseMap) {
        // helper.doTask3();
        // helper.doTask1();
    }

    public void afterUndelete(List<Case> newCases, Map<ID, SObject> newCaseMap) {
        // helper.doTask4();
        // helper.doTask2();
    }

}