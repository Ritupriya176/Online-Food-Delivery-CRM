public class FoodOrderManagement {
    // Create a new order
    public static Food_Orders__c createOrder(Contact customer, Restaurant__c restaurant, Decimal totalAmount) {
        Food_Orders__c order = new Food_Orders__c(
            Customer__c = customer.Id,
            Restaurant__c = restaurant.Id,
            Total_Amount__c = totalAmount,
            Status__c = 'New',
            Order_Date__c = System.now()
        );
        insert order;
        return order;
    }
    // Update order status
    public static void updateOrderStatus(Id orderId, String newStatus) {
        Food_Orders__c order = [SELECT Id, Status__c FROM Food_Orders__c WHERE Id = :orderId];
        order.Status__c = newStatus;
        update order;
    }
    // Calculate Grand Total from Order Line Items
    public static Decimal calculateGrandTotal(Id orderId) {
        Decimal total = 0;
        List<Order_Line_Item__c> items = [SELECT Total__c FROM Order_Line_Item__c WHERE Food_Order__c = :orderId];
        for(Order_Line_Item__c item : items){
            total += item.Total__c;
        }
        return total;
    }
}