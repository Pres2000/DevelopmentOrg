public with sharing class Order_Trigger_Handler extends TriggerHandler {
    public override void beforeUpdate() {
      OrderItemUtility.addBonusBouquet(Trigger.new);
    }
}
