public class OrderLineItemHandler {

    public static void updateFoodOrderTotal(Map<Id, Order_Line_Item__c> newMap,
                                            Map<Id, Order_Line_Item__c> oldMap,
                                            Boolean isDelete) {
        Set<Id> foodOrderIds = new Set<Id>();

        if(isDelete){
            for(Order_Line_Item__c oldItem : oldMap.values()){
                if(oldItem.Food_Order__c != null)
                    foodOrderIds.add(oldItem.Food_Order__c);
            }
        } else {
            for(Order_Line_Item__c item : newMap.values()){
                if(item.Food_Order__c != null)
                    foodOrderIds.add(item.Food_Order__c);
            }
        }

        FoodOrderService.calculateGrandTotal(foodOrderIds);
    }
}