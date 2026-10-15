@IsTest
private class ParkLocatorTest {
    @IsTest static void returnsParks() {
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        Test.startTest();
        List<String> result = ParkLocator.country('United States');
        Test.stopTest();
        System.assertEquals(new List<String>{'Yosemite', 'Sequoia', 'Crater Lake'}, result);
    }
    @IsTest static void rejectsBlankCountry() {
        try {
            ParkLocator.country('  ');
            System.assert(false, 'Expected validation');
        } catch (ParkLocator.ParkLocatorException expected) {
            System.assert(expected.getMessage().contains('required'));
        }
    }
}
