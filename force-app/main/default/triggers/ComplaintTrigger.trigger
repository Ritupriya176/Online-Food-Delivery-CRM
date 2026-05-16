trigger ComplaintTrigger on Complaint__c (after update) {
    ComplaintHandler.updateOrderOnComplaint(Trigger.new, Trigger.oldMap);
}