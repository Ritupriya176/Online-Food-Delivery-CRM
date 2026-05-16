import { LightningElement, api, wire } from 'lwc';
import getMenuItems from '@salesforce/apex/MenuItemController.getMenuItems';

export default class MenuItemsList extends LightningElement {
    @api recordId; // Restaurant Id
    menuItems;

    @wire(getMenuItems, { restaurantId: '$recordId' })
    wiredItems({ error, data }) {
        if(data){
            this.menuItems = data;
        } else if(error){
            this.error = error;
        }
    }
}
