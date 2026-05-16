@isTest
public class ComplaintHandlerTest {

    @testSetup
    static void setupData(){
        // Restaurant
        Restaurant__c res = new Restaurant__c(Name='Test Res', Location__c='Area', Cuisine__c='Italian');
        insert res;

        // Food Order
        Food_Orders__c order = new Food_Orders__c(Status__c='Pending', Restaurant__c=res.Id, Total_Amount__c=0);
        insert order;

        // Complaint
        Complaint__c comp = new Complaint__c(Food_Order__c=order.Id, Status__c='Open');
        insert comp;
    }

    static testMethod void testUpdateOrderOnComplaint(){
        Complaint__c comp = [SELECT Id, Status__c, Food_Order__c FROM Complaint__c LIMIT 1];

        // Resolve complaint
        comp.Status__c = 'Resolved';
        update comp;

        // Verify Food Order status updated (if your handler does that)
        Food_Orders__c order = [SELECT Id, Status__c FROM Food_Orders__c WHERE Id = :comp.Food_Order__c];
        System.assertEquals('Delivered', order.Status__c);
    }
}