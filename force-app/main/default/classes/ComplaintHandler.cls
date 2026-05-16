public class ComplaintHandler {
    public static void updateOrderOnComplaint(List<Complaint__c> newComplaints,
                                              Map<Id, Complaint__c> oldMap) {
        Set<Id> orderIds = new Set<Id>();
        for(Complaint__c comp : newComplaints){
            Complaint__c oldComp = oldMap.get(comp.Id);
            if(comp.Status__c == 'Resolved' && oldComp.Status__c != 'Resolved'){
                if(comp.Food_Order__c != null)
                    orderIds.add(comp.Food_Order__c);
            }
        }
        if(orderIds.isEmpty()) return;

        List<Food_Orders__c> ordersToUpdate = [SELECT Id, Status__c FROM Food_Orders__c WHERE Id IN :orderIds];
        for(Food_Orders__c order : ordersToUpdate){
            order.Status__c = 'Delivered';
        }
        try {
            update ordersToUpdate;
        } catch(DmlException e){
            System.debug('Error updating Food Orders from Complaint: ' + e.getMessage());
        }
    }
}