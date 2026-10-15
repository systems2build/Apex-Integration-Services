public without sharing class ParkLocator {
    public class ParkLocatorException extends Exception {}
    public static List<String> country(String countryName) {
        if (String.isBlank(countryName)) {
            throw new ParkLocatorException('Country is required.');
        }
        ParkService.ParksImplPort service = new ParkService.ParksImplPort();
        List<String> result = service.byCountry(countryName.trim());
        return result == null ? new List<String>() : result;
    }
}
