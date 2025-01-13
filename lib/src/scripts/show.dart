import 'dart:convert';
import 'dart:typed_data';

import 'package:namecoin/src/constants.dart';
import 'package:namecoin/src/scripts/tools.dart';

/// construct the script hash from the name
///
/// the name must be UTF-8 valid.
/// Will return a param to send with a request to the daemon for fetching transactions with the name.
/// Example:
///```dart
/// final String sh = nameIdentifierToScriptHash("d/myname");
/// final txs_with_myname = await client.request('blockchain.scripthash.get_history', sh);
///```
/// correspond to name_identifier_to_scripthash from electrum-nmc
/// https://github.com/namecoin/electrum-nmc/blob/aaa705f40276fe2933f1942dadb067cb12d7ed5b/electrum_nmc/electrum/names.py#L154
String nameIdentifierToScriptHash(String name) {
  final identifier = ascii.encode(name);
  final nameOp = {
    "op": opCodeNameUpdateValue,
    "name": identifier,
    "value": Uint8List.fromList([])
  };
  final script = '${nameOpToScript(nameOp)}6a';
  return scriptToScriptHash(script);
}
