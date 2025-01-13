import 'package:namecoin/src/scripts/show.dart';
import 'package:test/test.dart';

void main() {
  /// Tests to check if the public function to construct script to search for name is correct
  /// It is compared to the scriptHash produced by electrum-nmc wallet using the name_show('d/testsw') command
  test(
      "script Hash compared to thosesproduct by namecoin-nmc for the same name",
      () {
    expect(nameIdentifierToScriptHash("d/testsw"),
        'fd85c958f75f17995d07d996590d624688a11b5a0bc01a2a190aeb4921941cb7');
    expect(nameIdentifierToScriptHash("d/tests"),
        'e00012976497c42daf52110d19b92c80a718a87cc715d8dbf45fa0f90a0aaa07');
    expect(nameIdentifierToScriptHash("d/stackwallet"),
        'aec5d2aa544f9bd7d3e61121b042f3c79d6026e0af18ef30f0eba8c633b6097a');
    expect(nameIdentifierToScriptHash("d/01"),
        'eea6c46dc4a46af26502396b223cda41a141d4de8f8330a946d02c81cfee53f4');
  });
}
