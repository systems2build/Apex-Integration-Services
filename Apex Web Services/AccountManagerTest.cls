@IsTest
private class AccountManagerTest {
    private static void setRequest(String path) {
        RestRequest request = new RestRequest();
        request.requestURI = path;
        request.httpMethod = 'GET';
        RestContext.request = request;
        RestContext.response = new RestResponse();
    }
    @IsTest static void returnsAccountAndContacts() {
        Account account = new Account(Name = 'Sample Account');
        insert account;
        insert new Contact(AccountId = account.Id, FirstName = 'Test', LastName = 'Contact');
        setRequest('/services/apexrest/Accounts/' + account.Id + '/contacts');
        Test.startTest();
        Account result = AccountManager.getAccount();
        Test.stopTest();
        System.assertEquals(200, RestContext.response.statusCode);
        System.assertEquals('Sample Account', result.Name);
        System.assertEquals(1, result.Contacts.size());
    }
    @IsTest static void rejectsNonAccountIdentifier() {
        Contact record = new Contact(LastName = 'Test');
        insert record;
        setRequest('/services/apexrest/Accounts/' + record.Id + '/contacts');
        System.assertEquals(null, AccountManager.getAccount());
        System.assertEquals(400, RestContext.response.statusCode);
    }
    @IsTest static void returnsNotFoundForDeletedAccount() {
        Account record = new Account(Name = 'Deleted');
        insert record;
        Id recordId = record.Id;
        delete record;
        setRequest('/services/apexrest/Accounts/' + recordId + '/contacts');
        System.assertEquals(null, AccountManager.getAccount());
        System.assertEquals(404, RestContext.response.statusCode);
    }
}
