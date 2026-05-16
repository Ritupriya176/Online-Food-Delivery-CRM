@isTest
public class OrderLineItemHandlerTest {

    @testSetup
    static void setupData(){
        // Create Restaurant
        Restaurant__c res = new Restaurant__c(Name='Test Res', Location__c='Area', Cuisine__c='Italian');
        insert res;

        // Food Order
        Food_Orders__c order = new Food_Orders__c(Status__c='Pending', Restaurant__c=res.Id, Total_Amount__c=0);
        insert order;

        // Menu Item
        Menu_Item__c menu = new Menu_Item__c(Name='Pasta', Price__c=150, Restaurant__c=res.Id);
        insert menu;

        // Order Line Item
        Order_Line_Item__c line = new Order_Line_Item__c(Food_Order__c=order.Id, Menu_Item__c=menu.Id, Quantity__c=1, Unit_Price__c=150);
        insert line;
    }

    static testMethod void testUpdateFoodOrderTotal(){
        Order_Line_Item__c line = [SELECT Id, Food_Order__c, Quantity__c FROM Order_Line_Item__c LIMIT 1];

        // Update quantity
        line.Quantity__c = 3;
        update line;

        // Verify Food Order total updated
        Food_Orders__c order = [SELECT Id, Total_Amount__c FROM Food_Orders__c WHERE Id = :line.Food_Order__c];
        System.assertEquals(450, order.Total_Amount__c);
    }
}