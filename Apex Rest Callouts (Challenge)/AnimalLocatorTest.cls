@IsTest
private class AnimalLocatorTest {
    private class FailureMock implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest request) {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(503);
            response.setBody('Service unavailable');
            return response;
        }
    }
    private class MalformedMock implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest request) {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setBody('not-json');
            return response;
        }
    }
    @IsTest static void returnsAnimalName() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        Test.startTest();
        String result = AnimalLocator.getAnimalNameById(1);
        Test.stopTest();
        System.assertEquals('moose', result);
    }
    @IsTest static void rejectsBadIdentifier() {
        try {
            AnimalLocator.getAnimalNameById(0);
            System.assert(false, 'Expected rejection');
        } catch (AnimalLocator.AnimalLocatorException expected) {
            System.assert(expected.getMessage().contains('positive'));
        }
    }
    @IsTest static void handlesHttpFailure() {
        Test.setMock(HttpCalloutMock.class, new FailureMock());
        try {
            AnimalLocator.getAnimalNameById(1);
            System.assert(false, 'Expected service failure');
        } catch (AnimalLocator.AnimalLocatorException expected) {
            System.assert(expected.getMessage().contains('failed'));
        }
    }
    @IsTest static void handlesMalformedJson() {
        Test.setMock(HttpCalloutMock.class, new MalformedMock());
        try {
            AnimalLocator.getAnimalNameById(1);
            System.assert(false, 'Expected invalid payload');
        } catch (AnimalLocator.AnimalLocatorException expected) {
            System.assert(expected.getMessage().contains('invalid'));
        }
    }
}
