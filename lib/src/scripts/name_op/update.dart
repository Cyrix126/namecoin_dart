import 'dart:convert';

import 'package:namecoin/src/constants.dart';
import 'package:namecoin/src/scripts/tools.dart';
import 'package:namecoin/src/scripts/validators.dart';

/// Generate a pubScriptKey to update a value to a name (NAME_UPDATE).
///
/// This pubscriptKey can be inserted into an output for a new transaction.
String scriptNameUpdate(String name, String value) {
  final identifier = ascii.encode(name);
  validateIdentifierLength(identifier);
  final valueBytes = ascii.encode(value);
  validateValueLength(valueBytes);
  final nameOp = {
    "op": opCodeNameUpdateValue,
    "name": identifier,
    "value": valueBytes
  };
  return nameOpToScript(nameOp);
}
