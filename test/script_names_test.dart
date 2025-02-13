import 'dart:convert';

import 'package:namecoin/namecoin.dart';
import 'package:test/test.dart';

const name = 'd/testsw';
const privKey = 'TjjiQXjN7H6caZi2R3qEKNtgvvdVB2ZZGgKg1EpETWZiVHmg7xL2';

void main() {
  /// Tests to check if the 3 pubScriptKey constructions of the name operations execute without throwing exception.
  test("NameNew output", () async {
    final (_, salt, _) = await scriptNameNew(name);
    scriptNameFirstUpdate(name, "myvalue", salt);
    scriptNameUpdate(name, "mysecondvalue");
  });

  /// Test that using the same private key with the same name will produce the same salt.
  test("Deterministic salt", () async {
    final (_, salt, _) = await scriptNameNew(name, ascii.encode(privKey));
    final (_, saltIdentical, _) =
        await scriptNameNew(name, ascii.encode(privKey));
    expect(salt, saltIdentical);
  });
}
