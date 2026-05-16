public with sharing class FoodOrderController {
    @AuraEnabled(cacheable=true)
    public static List<Food_Orders__c> getFoodOrders() {
        return [SELECT Id, Name, Total_Amount__c FROM Food_Orders__c LIMIT 10];
    }
}