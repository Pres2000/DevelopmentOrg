public without sharing class MaintenanceRequestTriggerHelper {
    public MaintenanceRequestTriggerHelper() {
        System.debug('Inside MaintenanceRequestTriggerHelper Constructor');

    }
    public void updateMaintenanceRequests(List<Case> newMaintenanceReqInput, Map<Id, SObject> oldMaintenanceReqInput) {
        System.debug('Inside updateMaintenanceRequests helper method');
        System.debug('new case list ' + JSON.serializePretty(newMaintenanceReqInput));
        System.debug('old case map ' + JSON.serializePretty(oldMaintenanceReqInput));

        // Set to store all of the IDs from maintenance requests that are closed
        Set<Id> closedMaintenanceRequestIds = new Set<Id>();

        // Loop through each new maintenance request
        for (Case maintenanceRequest : newMaintenanceReqInput) {
            Case oldMaintenanceRequst = (Case) oldMaintenanceReqInput.get(maintenanceRequest.Id);
            
            // Check if the maintenance request is closed, has type Repair or Routine Maintenance, and the old status was not closed
            if (maintenanceRequest.Status == 'Closed' && (maintenanceRequest.Type == 'Repair' || maintenanceRequest.Type == 'Routine Maintenance' ) && oldMaintenanceRequst.Status != 'Closed') {

                // Retrieve the related Vehicle and Equipment records
                Vehicle__c relatedVehicle = [SELECT Id, Name FROM Vehicle__c WHERE Id = :maintenanceRequest.Vehicle__c];
                List<Equipment_Maintenance_Item__c> maintenanceItems = [SELECT Id, Name FROM Equipment_Maintenance_Item__c WHERE Maintenance_Request__c = :maintenanceRequest.Id];

                // Loop over the equipment maintenance items and add their maintenance cycles to a list
                Set<integer> maintenanceCycles = new Set<Integer>();

                for (Equipment_Maintenance_Item__c maintenanceItem : maintenanceItems) {
                    Product2 relatedEquipment = [SELECT Id, Name, Maintenance_Cycle__c FROM Product2 WHERE Id = :maintenanceItem.Equipment__c];
                    maintenanceCycles.add(relatedEquipment.Maintenance_Cycle__c.intValue());

                }

                // Find the smallest maintenace cycle
                Integer smallestMaintenanceCycle = null;
                for (Integer maintenanceCycle : maintenanceCycles) {
                    if (smallestMaintenanceCycle == null || maintenanceCycle < smallestMaintenanceCycle) {
                        smallestMaintenanceCycle = maintenanceCycle;
                    }
                }

                // Create a new maintenance request record
                Case newMaintenanceRequest = new Case();
                newMaintenanceRequest.Subject = 'Routine Maintenance';
                newMaintenanceRequest.Type = 'Routine Maintenance';
                newMaintenanceRequest.Status = 'New'; 
                newMaintenanceRequest.Date_Reported__c = Date.today();
                newMaintenanceRequest.Date_Due__c = Date.today().addDays(smallestMaintenanceCycle);
                newMaintenanceRequest.Vehicle__c = relatedVehicle.Id;

                insert newMaintenanceRequest;

                // List of equipment maintenance items we want to update with the new case
                List<Equipment_Maintenance_Item__c> equipmentItemsToUpdate = new List<Equipment_Maintenance_Item__c>();

                // Loop over the Equipment and assign the new maintenance request to the items
                for (Equipment_Maintenance_Item__c item : maintenanceItems) {
                    item.Maintenance_Request__c = newMaintenanceRequest.Id;
                    equipmentItemsToUpdate.add(item);
                }

                // Update our list of items
                update equipmentItemsToUpdate;

            }
        }

    }
}