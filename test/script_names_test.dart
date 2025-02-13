import 'package:coinlib/coinlib.dart';
import 'package:namecoin/namecoin.dart';
import 'package:test/test.dart';

const name = 'mytestname';
const privKeyHex =
    'bdf038bbab2e95bb184b5327dec4c0ced5adfe100745f5ddcc17f6da8f8d876f';
const expectedSalt = "0539dedcdb7a0f428d14cdcc27f217e0a01ad9f6";

void main() {
  /// Tests to check if the 3 pubScriptKey constructions of the name operations execute without throwing exception.
  test("NameNew output", () {
    final (_, salt, _) = scriptNameNew(name);
    scriptNameFirstUpdate(name, "myvalue", salt);
    scriptNameUpdate(name, "mysecondvalue");
  });

  /// Test that using the same private key with the same name will produce the same salt.
  test("Deterministic salt", () {
    final (_, salt, _) = scriptNameNew(name, hexToBytes(privKeyHex));
    final (_, saltIdentical, _) = scriptNameNew(name, hexToBytes(privKeyHex));
    expect(salt, saltIdentical);
  });

  /// Verifies that scriptNameNew generates the correct salt for a given name and private key.
  test("scriptNameNew generates expected salt", () {
    final (_, salt, _) = scriptNameNew("mytestname", hexToBytes(privKeyHex));
    expect(salt.toString(), expectedSalt);
  });
}
