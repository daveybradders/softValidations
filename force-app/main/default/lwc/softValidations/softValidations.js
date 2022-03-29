/**
 * @description       : SoftValidations JS
 * @author            : david.bradburn@hyphen8.com
 *
 * Modifications Log 
 * Ver   Date         Author                            Modification
 * 1.0   20-02-2022   david.bradburn@hyphen8.com        Initial Version
**/

import { LightningElement, track, api, wire } from 'lwc';
import getValidationMessage from '@salesforce/apex/SoftValidationsController.getMessage';
import {getRecord } from 'lightning/uiRecordApi';

export default class SoftValidations extends LightningElement {

    // setup api elements
    @api recordId;
    @api objectApiName;
    @api notificationTitle;
    @api componentStyling;
    @api validationMessage;
    @api validationCriteria;
    @api validationIcon;

    // setup track elements
    message;
    errors;
    hasMessages = false;

    // Wire getRecord to trigger on record update / call out handleGetMessages() method
    @wire(getRecord, { recordId: '$recordId', layoutTypes: ['Full']})
    getCurrentRecord({ data, error }) {
        console.log('accountRecord => ', data, error);
        if (data) {
            this.handleGetMessages();
        } else if (error) {
            console.error('ERROR => ', JSON.stringify(error)); // handle error properly
        }
    };

    // get our message to display
    handleGetMessages() {
        getValidationMessage({
            recordId: this.recordId,
            objectName: this.objectApiName,
            whereClause: this.validationCriteria
        })
        .then((results) => {
            //this.message = results;
            console.log('Result: ' + results);
            if(results.length > 0){
                this.hasMessages = true;
            } else {
                this.hasMessages = false;
            }
            this.errors = undefined;  
        })
        .catch((error) => {
            this.errors = JSON.stringify(error);
            this.messages = undefined;
        });

        console.log('Message: ' + this.message); 
    }

    // get the styling for the alert based on the property
    get alertStyling() {
        return 'slds-notify slds-p-around_medium ' + this.componentStyling;
    }

    // handle errors no output for it back handling anyway
    errorCallback(error) {
        this.errors = error;
    }
}