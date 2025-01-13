import 'dart:convert';

import 'package:coinlib/coinlib.dart';
import 'package:namecoin/src/constants.dart';
import 'package:namecoin/src/scripts/tools.dart';
import 'package:namecoin/src/scripts/validators.dart';

/// Generate a pubScriptKey to apply a value to a name for the first time (NAME_FIRSTUPDATE).
///
/// This pubscriptKey can be inserted into an output for a new transaction.
String scriptNameFirstUpdate(String name, String value, String saltHex) {
  final identifier = ascii.encode(name);
  validateIdentifierLength(identifier);
  final valueBytes = ascii.encode(value);
  validateValueLength(valueBytes);
  final salt = hexToBytes(saltHex);
  validateSaltLength(salt);
  final nameOp = {
    "op": opCodeNameFirstUpdateValue,
    "name": identifier,
    "salt": salt,
    "value": valueBytes
  };
  return nameOpToScript(nameOp);
}
