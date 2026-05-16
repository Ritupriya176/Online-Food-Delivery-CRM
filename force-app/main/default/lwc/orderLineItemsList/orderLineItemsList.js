import { LightningElement, api, wire } from 'lwc';
import getOrderLineItems from '@salesforce/apex/OrderLineItemController.getOrderLineItems';

export default class OrderLineItemsList extends LightningElement {
    @api recordId;
    lineItems;

    @wire(getOrderLineItems, { orderId: '$recordId' })
    wiredItems({ error, data }) {
        if(data){
            this.lineItems = data;
        } else if(error){
            this.error = error;
        }
    }
}
