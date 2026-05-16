public with sharing class OrderLineItemController {
    @AuraEnabled(cacheable=true)
    public static List<Order_Line_Item__c> getOrderLineItems(Id orderId) {
        return [SELECT Id, Quantity__c, Total__c, Menu_Item__r.Name
                FROM Order_Line_Item__c
                WHERE Food_Order__c = :orderId];
    }
}