trigger orderTrigger on Order (before update) {
  OrderItemUtility.addBonusBouquet(Trigger.new);
  // new Order_Trigger_Handler().run();
}
