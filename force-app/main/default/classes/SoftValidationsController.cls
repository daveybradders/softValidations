/**
* @description      Reusable SoftValidations component to display advisory field conditions
* @author           david.bradburn@hyphen8.com
* @date             20-02-2022
* @group            Controller
*/

public with sharing class SoftValidationsController {

    /**
     * @description         aura method that takes a recordid / objectname and fieldapi name and then returns the contents of the field to the lightning component
     * @param               recordId        - this is the recordid you want to use to find data on the record
     * @param               objectName      - this is the objectname that the method has been opened on
     * @param               fieldAPIName    - this is the API name for the field you want to query
     * @param               whereClause     - this is the API name for the WHERE clause validation
     * @return              message(string) - passes back 'Validation Match!' or NULL, depending on that validation check
    */
    @AuraEnabled
    public static String getMessage(string recordId, string objectName, string fieldAPIName, string whereClause)
    {
        // setup a string for the message we will return
        string message;
        list<sObject> result = new list<sObject>();

        // try and get the message
        try {
            // setup our query
            string query = 'SELECT Id FROM ' + objectName + ' WHERE ' + whereClause + ' AND ID = :recordId';
            
            result = Database.query(query);

            system.debug('result: ' + result);

            if(result.size() == 0){
                message = '';
            } else {
                message = 'Validation Match!';
            }

        } catch (Exception e){
            system.debug(e.getMessage());
        }
        
        // return our message
        return message;
    }
}