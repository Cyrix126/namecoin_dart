import 'package:namecoin/namecoin.dart';
import 'package:test/test.dart';

const name = 'd/testsw';
void main() {
  /// Tests to check if the 3 pubScriptKey constructions of the name operations execute without throwing exception.
  test("NameNew output", () {
    final (_, salt, _) = scriptNameNew(name);
    scriptNameFirstUpdate(name, "myvalue", salt);
    scriptNameUpdate(name, "mysecondvalue");
  });
}
