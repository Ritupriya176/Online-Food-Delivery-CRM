@isTest
public class FoodOrderServiceTest {

    @testSetup
    static void setupData(){
        // Create a Restaurant
        Restaurant__c res = new Restaurant__c(
            Name = 'Test Restaurant',
            Location__c = 'Test Area',
            Cuisine__c = 'Italian'
        );
        insert res;

        // Create a Food Order
        Food_Orders__c order = new Food_Orders__c(
            Status__c = 'Pending',
            Restaurant__c = res.Id,
            Total_Amount__c = 0
        );
        insert order;

        // Create Menu Item
        Menu_Item__c menu = new Menu_Item__c(
            Name = 'Pizza',
            Price__c = 100,
            Restaurant__c = res.Id
        );
        insert menu;

        // Create Order Line Item
        Order_Line_Item__c line = new Order_Line_Item__c(
            Food_Order__c = order.Id,
            Menu_Item__c = menu.Id,
            Quantity__c = 2,
            Unit_Price__c = 100
        );
        insert line;
    }

    static testMethod void testCalculateGrandTotal(){
        Food_Orders__c order = [SELECT Id, Total_Amount__c FROM Food_Orders__c LIMIT 1];

        // Call the service method
        Set<Id> orderIds = new Set<Id>{order.Id};
        FoodOrderService.calculateGrandTotal(orderIds);

        // Verify the total
        order = [SELECT Id, Total_Amount__c FROM Food_Orders__c WHERE Id = :order.Id];
        System.assertEquals(200, order.Total_Amount__c);
    }

    static testMethod void testFoodOrderTrigger(){
        Food_Orders__c order = [SELECT Id, Status__c, Total_Amount__c FROM Food_Orders__c LIMIT 1];

        // Update status to simulate trigger (no Delivery)
        order.Status__c = 'Processing';
        update order;

        // Verify totals remain correct
        Food_Orders__c updatedOrder = [SELECT Id, Total_Amount__c FROM Food_Orders__c WHERE Id = :order.Id];
        System.assertEquals(200, updatedOrder.Total_Amount__c);
    }
}