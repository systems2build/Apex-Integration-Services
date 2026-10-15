@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        if (request == null || String.isBlank(request.requestURI)) {
            setStatus(400);
            return null;
        }
        String rawId = request.requestURI.substringBetween('/Accounts/', '/contacts');
        if (String.isBlank(rawId)) {
            setStatus(400);
            return null;
        }
        Id accountId;
        try {
            accountId = (Id) rawId;
        } catch (Exception error) {
            setStatus(400);
            return null;
        }
        if (accountId.getSObjectType() != Account.SObjectType) {
            setStatus(400);
            return null;
        }
        try {
            List<Account> matches = [
                SELECT Id, Name,
                    (SELECT Id, FirstName, LastName FROM Contacts)
                FROM Account
                WHERE Id = :accountId
                WITH SECURITY_ENFORCED
                LIMIT 1
            ];
            if (matches.isEmpty()) {
                setStatus(404);
                return null;
            }
            setStatus(200);
            return matches[0];
        } catch (System.QueryException error) {
            setStatus(403);
            return null;
        }
    }
    private static void setStatus(Integer code) {
        if (RestContext.response == null) {
            RestContext.response = new RestResponse();
        }
        RestContext.response.statusCode = code;
    }
}
