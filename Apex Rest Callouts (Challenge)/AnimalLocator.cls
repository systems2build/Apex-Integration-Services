public class AnimalLocator {
    public class AnimalLocatorException extends Exception {}

    // Trailhead sample endpoint. Use a Named Credential for production reuse.
    public static String getAnimalNameById(Integer animalId) {
        if (animalId == null || animalId <= 0) {
            throw new AnimalLocatorException('Animal ID must be positive.');
        }
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + animalId);
        request.setMethod('GET');
        request.setTimeout(10000);

        HttpResponse response = new Http().send(request);
        if (response == null || response.getStatusCode() != 200) {
            throw new AnimalLocatorException('Animal lookup failed.');
        }
        try {
            Map<String, Object> data =
                (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Map<String, Object> animal =
                data == null ? null : (Map<String, Object>) data.get('animal');
            Object name = animal == null ? null : animal.get('name');
            if (name == null || String.isBlank(String.valueOf(name))) {
                throw new AnimalLocatorException('Animal response has no name.');
            }
            return String.valueOf(name);
        } catch (AnimalLocatorException error) {
            throw error;
        } catch (Exception error) {
            throw new AnimalLocatorException('Animal response is invalid.');
        }
    }
}
