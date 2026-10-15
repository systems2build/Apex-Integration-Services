# Apex Integration Services

Learning examples for Salesforce Apex REST callouts, SOAP callouts, and custom REST services. These files originate from Trailhead exercises and are not production-ready deployment packages.

## Examples

- Apex Rest Callouts (Challenge): HTTP response validation, JSON parsing, positive and negative mock tests.
- Apex SOAP Callouts(Challenge): generated WSDL client, mock SOAP client, and input validation.
- Apex Web Services: Account/Contacts REST endpoint with sharing, security-enforced SOQL, and bounded error states.

## Build And Verify

- Run npm test with Node 20+ to execute lightweight source-contract checks.
- Import Apex classes into a disposable Salesforce org and run AnimalLocatorTest, ParkLocatorTest, and AccountManagerTest.
- Confirm Apex REST object/field permissions with a least-privilege user.
- Configure callout allowlisting or a Named Credential. Original sample Heroku endpoints have not been checked for availability.

This educational repository intentionally keeps the historical folder layout. It does not include Salesforce DX metadata or a supported build pipeline, and its source checks do not demonstrate Apex compilation, deployment, or endpoint availability.
