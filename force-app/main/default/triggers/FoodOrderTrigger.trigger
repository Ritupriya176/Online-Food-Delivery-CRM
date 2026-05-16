trigger FoodOrderTrigger on Food_Orders__c (after update) {
    Set<Id> foodOrderIds = new Set<Id>();

    for(Food_Orders__c order : Trigger.new){
        Food_Orders__c oldOrder = Trigger.oldMap.get(order.Id);

        // If any relevant field changed (e.g., Status), we can add it here
        if(order.Status__c != oldOrder.Status__c){
            foodOrderIds.add(order.Id);
        }
    }

    if(!foodOrderIds.isEmpty()){
        // Recalculate totals or other logic in your service class
        FoodOrderService.calculateGrandTotal(foodOrderIds);
    }
}