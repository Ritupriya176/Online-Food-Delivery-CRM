@isTest
private class FoodDeliveryCRMApexTest {

    @isTest static void testOrderLineItemTrigger() {
        // Create Restaurant
        Restaurant__c r = new Restaurant__c(Name='Test Resto');
        insert r;

        // Create Customer
        Contact c = new Contact(LastName='Customer');
        insert c;

        // Create Food Order
        Food_Orders__c order = new Food_Orders__c(
            Customer__c = c.Id,
            Restaurant__c = r.Id,
            Status__c = 'New'
        );
        insert order;

        // Create Order Line Item
        Order_Line_Item__c oli = new Order_Line_Item__c(
            Food_Order__c = order.Id,
            Menu_Item__c = null, // optional
            Quantity__c = 2,
            Unit_Price__c = 50
        );
        insert oli;

        // Test trigger effect
        Food_Orders__c updatedOrder = [SELECT Total_Amount__c FROM Food_Orders__c WHERE Id=:order.Id];
        System.debug('Updated Order Total: ' + updatedOrder.Total_Amount__c);
        System.assertEquals(100, updatedOrder.Total_Amount__c);
    }

    @isTest static void testComplaintTrigger() {
        // Create Restaurant & Customer
        Restaurant__c r = new Restaurant__c(Name='Test Resto');
        insert r;

        Contact c = new Contact(LastName='Customer');
        insert c;

        // Create Food Order
        Food_Orders__c order = new Food_Orders__c(
            Customer__c = c.Id,
            Restaurant__c = r.Id,
            Status__c = 'Accepted'
        );
        insert order;

        // Create Complaint
        Complaint__c comp = new Complaint__c(
            Customer__c = c.Id,
            Food_Order__c = order.Id,
            Status__c = 'Open'
        );
        insert comp;

        // Update Complaint to Resolved
        comp.Status__c = 'Resolved';
        update comp;

        Food_Orders__c updatedOrder = [SELECT Status__c FROM Food_Orders__c WHERE Id=:order.Id];
        System.debug('Updated Order Status: ' + updatedOrder.Status__c);
        System.assertEquals('Delivered', updatedOrder.Status__c);
    }
}