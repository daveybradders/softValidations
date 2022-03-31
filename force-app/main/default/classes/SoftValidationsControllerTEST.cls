/**
 * @description     - Test Class for softValidations app
 * @author          - david.bradburn@hyphen8.com
 * @date            - 31/03/2022
 * @group           - Tests
*/
@isTest
public with sharing class SoftValidationsControllerTEST {
    
    /**
     * @description - Basic Validation TRIGGERED Test
    */
    static testMethod void testTriggerValidationTest(){
        Account acc = new Account(Name = 'TestAccount1');
        insert acc;

        string validationResponse = SoftValidationsController.getMessage(acc.Id, 'Account', 'Website = null');
        system.assertEquals('Validation Match!', validationResponse, 'Validation Triggered as website is indeed null');
    }

    /**
     * @description - Basic Validation NOT TRIGGERED Test
    */
    static testMethod void testNonTriggerValidationTest(){
        Account acc = new Account(Name = 'TestAccount1', Website = 'test.com');
        insert acc;

        string validationResponse = SoftValidationsController.getMessage(acc.Id, 'Account', 'Website = null');
        system.assertEquals('', validationResponse, 'Validation Not Triggered due to blank website');
    }

    /**
     * @description - Parent Record - Basic Validation TRIGGERED Test
    */
    static testMethod void testParentTriggerValidationTest(){
        Account acc = new Account(Name = 'TestAccount1');
        insert acc;

        Contact con = new Contact(LastName='TEST USER', AccountID=acc.Id);
        insert con;

        string validationResponse = SoftValidationsController.getMessage(con.Id, 'Contact', 'Account.Website = null');
        system.assertEquals('Validation Match!', validationResponse, 'Validation Triggered as website is indeed null');
    }

    /**
     * @description - Parent Record - Basic Validation NOT TRIGGERED Test
    */
    static testMethod void testPArentNonTriggerValidationTest(){
        Account acc = new Account(Name = 'TestAccount1', Website = 'test.com');
        insert acc;

        Contact con = new Contact(LastName='TEST USER', AccountID=acc.Id);
        insert con;

        string validationResponse = SoftValidationsController.getMessage(con.Id, 'Contact', 'Account.Website = null');
        system.assertEquals('', validationResponse, 'Validation Not Triggered due to blank website');
    }
}