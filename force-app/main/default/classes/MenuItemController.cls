public with sharing class MenuItemController {
    @AuraEnabled(cacheable=true)
    public static List<Menu_Item__c> getMenuItems(Id restaurantId) {
        return [SELECT Id, Name, Price__c, Category__c
                FROM Menu_Item__c
                WHERE Restaurant__c = :restaurantId];
    }
}