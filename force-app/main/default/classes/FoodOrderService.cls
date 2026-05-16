public class FoodOrderService {
    public static void calculateGrandTotal(Set<Id> foodOrderIds){
        List<Food_Orders__c> ordersToUpdate = [SELECT Id,
                                               (SELECT Quantity__c, Unit_Price__c FROM Order_Line_Items__r)
                                               FROM Food_Orders__c WHERE Id IN :foodOrderIds];
        for(Food_Orders__c order : ordersToUpdate){
            Decimal total = 0;
            for(Order_Line_Item__c item : order.Order_Line_Items__r){
                total += item.Quantity__c * item.Unit_Price__c;
            }
            order.Total_Amount__c = total;
        }
        try {
            update ordersToUpdate;
        } catch(DmlException e){
            System.debug('Error updating Food Orders total: ' + e.getMessage());
        }
     }
}