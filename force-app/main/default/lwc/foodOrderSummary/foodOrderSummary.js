import { LightningElement, wire } from 'lwc';
import getFoodOrders from '@salesforce/apex/FoodOrderController.getFoodOrders';

export default class FoodOrderSummary extends LightningElement {
    orders; // stores the food orders
    error;  // stores errors if any

    @wire(getFoodOrders)
    wiredOrders({ error, data }) {
        if (data) {
            this.orders = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.orders = undefined;
        }
    }
}
