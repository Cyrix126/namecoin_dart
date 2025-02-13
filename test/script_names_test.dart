import 'dart:convert';

import 'package:namecoin/namecoin.dart';
import 'package:test/test.dart';

const name = 'd/testsw';
const privKey = 'TjjiQXjN7H6caZi2R3qEKNtgvvdVB2ZZGgKg1EpETWZiVHmg7xL2';
const expectedSalt = "119437b0c7e3c1a225e3d50cd7357e3f61682647";

void main() {
  /// Tests to check if the 3 pubScriptKey constructions of the name operations execute without throwing exception.
  test("NameNew output", () {
    final (_, salt, _) = scriptNameNew(name);
    scriptNameFirstUpdate(name, "myvalue", salt);
    scriptNameUpdate(name, "mysecondvalue");
  });

  /// Test that using the same private key with the same name will produce the same salt.
  test("Deterministic salt", () {
    final (_, salt, _) = scriptNameNew(name, ascii.encode(privKey));
    final (_, saltIdentical, _) = scriptNameNew(name, ascii.encode(privKey));
    expect(salt, saltIdentical);
  });

  /// Verifies that scriptNameNew generates the correct salt for a given name and private key.
  test("scriptNameNew generates expected salt", () {
    final (_, salt, _) = scriptNameNew(name, ascii.encode(privKey));
    expect(salt.toString(), expectedSalt);
  });
}
