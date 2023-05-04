/* eslint-disable no-alert */
import { LightningElement, api } from 'lwc';
import Account_Name from '@salesforce/schema/Account.Name';
import Account_Industry from '@salesforce/schema/Account.Industry';

export default class LightningRecordForm extends LightningElement {
    /*
        force:hasRecord - recordId
        force:hasSobjectName - objectAPIName
    */

    @api recordId;
    @api objectApiName;
    fields = [Account_Name, Account_Industry];
    handleSuccess() {
        alert('  Success Called  ');
    }

}