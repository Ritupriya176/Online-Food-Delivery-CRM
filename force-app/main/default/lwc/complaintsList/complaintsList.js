import { LightningElement, api, wire } from 'lwc';
import getComplaints from '@salesforce/apex/ComplaintController.getComplaints';

export default class ComplaintsList extends LightningElement {
    @api recordId; // Food Order Id
    complaints;

    @wire(getComplaints, { orderId: '$recordId' })
    wiredComplaints({ error, data }) {
        if(data){
            this.complaints = data;
        } else if(error){
            this.error = error;
        }
    }
}
