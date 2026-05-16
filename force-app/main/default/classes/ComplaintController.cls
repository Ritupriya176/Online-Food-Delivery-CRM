public with sharing class ComplaintController {
    @AuraEnabled(cacheable=true)
    public static List<Complaint__c> getComplaints(Id orderId) {
        return [SELECT Id, Name, Status__c, Complaint_Type__c
                FROM Complaint__c
                WHERE Food_Order__c = :orderId];
    }
}