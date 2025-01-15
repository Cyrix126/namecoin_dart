import 'package:namecoin/src/constants.dart';
import 'package:namecoin/src/scripts/parsing.dart';
import 'package:test/test.dart';

const scriptNewHex =
    '5114ad52101edc97f205ced33f67cf319f97eb6354706d00145e06345dbebd7b0da937eac19944dfb01de22304';

const scriptFirstUpdateHex =
    '5208642f74657374737714fde80a79d760799ee20a3bba342ce784c4354a074c567b226970223a5b223138382e3131342e39372e32222c223138382e3131342e39362e32225d2c22697036223a5b22326130363a393863313a333132313a3a32222c22326130363a393863313a333132303a3a32225d7d6d6d0014dd26b763361559fd39989907c21d2a15d7fb5057';

const scriptUpdateHex =
    '5308642f7465737473774c567b226970223a5b223138382e3131342e39372e32222c223138382e3131342e39362e32225d2c22697036223a5b22326130363a393863313a333132313a3a32222c22326130363a393863313a333132303a3a32225d7d6d7500141ace3054b2449e7ca09cd1f61fab7950e1e4f85a';

const String scriptNonNamesHex = '001417051691bc8a3a5a6e9784f0de4bd2a0a94a5919';

const commitment = 'ad52101edc97f205ced33f67cf319f97eb635470';
const salt = 'fde80a79d760799ee20a3bba342ce784c4354a07';
const name = 'd/testsw';

void main() {
  test("parsing of scriptPubKey hex of an NAME_NEW transaction", () {
    final opData = parsePubScriptKeyHex(scriptNewHex);
    expect(opData["op"], opNameNew);
    expect(opData["hash"], commitment);
  });
  test("parsing of scriptPubKey hex of an NAME_FIRSTUPDATE transaction", () {
    final opData = parsePubScriptKeyHex(scriptFirstUpdateHex);
    expect(opData["op"], opNameFirstUpdate);
    expect(opData["rand"], salt);
    expect(opData["name"], name);
  });
  test("parsing of scriptPubKey hex of an NAME_UPDATE transaction", () {
    final opData = parsePubScriptKeyHex(scriptUpdateHex);
    expect(opData["op"], opNameUpdate);
    expect(opData["name"], name);
  });
  test("parsing of scriptPubKey hex of a non op name transaction", () {
    expect(() => parsePubScriptKeyHex(scriptNonNamesHex), throwsException);
  });
}
