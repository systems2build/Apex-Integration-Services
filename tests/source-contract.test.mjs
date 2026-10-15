import { readFileSync } from 'node:fs';
import { join } from 'node:path';
import { test } from 'node:test';
import { strict as assert } from 'node:assert';
const read = (folder, name) => readFileSync(join(folder, name), 'utf8');
test('REST callout validates status and input', () => {
  const source = read('Apex Rest Callouts (Challenge)', 'AnimalLocator.cls');
  assert.match(source, /animalId <= 0/);
  assert.match(source, /getStatusCode\(\) != 200/);
  assert.match(source, /JSON\.deserializeUntyped/);
});
test('Account endpoint restricts sharing, fields, and errors', () => {
  const source = read('Apex Web Services', 'AccountManager.cls');
  assert.match(source, /global with sharing class AccountManager/);
  assert.match(source, /WITH SECURITY_ENFORCED/);
  for (const status of [200, 400, 403, 404]) {
    assert.ok(source.includes('setStatus(' + status + ')'));
  }
});
test('positive and negative Apex tests exist', () => {
  for (const [folder, name] of [
    ['Apex Rest Callouts (Challenge)', 'AnimalLocatorTest.cls'],
    ['Apex SOAP Callouts(Challenge)', 'ParkLocatorTest.cls'],
    ['Apex Web Services', 'AccountManagerTest.cls']
  ]) {
    const code = read(folder, name);
    assert.match(code, /@IsTest/i);
    assert.match(code, /rejects|Failure|NotFound|handles/i);
  }
});
