trigger OrderLineItemTrigger on Order_Line_Item__c (after insert, after update, after delete) {
    if(Trigger.isInsert || Trigger.isUpdate){
        OrderLineItemHandler.updateFoodOrderTotal(Trigger.newMap, Trigger.oldMap, false);
    } else if(Trigger.isDelete){
        OrderLineItemHandler.updateFoodOrderTotal(null, Trigger.oldMap, true);
    }
}