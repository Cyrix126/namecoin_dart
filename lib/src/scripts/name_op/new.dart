import 'dart:convert';
import 'dart:typed_data';

import 'package:coinlib/coinlib.dart';
import 'package:namecoin/src/constants.dart';
import 'package:namecoin/src/scripts/tools.dart';
import 'package:namecoin/src/scripts/validators.dart';
import 'package:pointycastle/api.dart';

/// Generate a pubScriptKey to register a new name.
///
/// Does not check if the name is already taken.
/// Returns the salt and the commitment that are necessary
/// when first updating the name from this output.
/// Returns (script, salt, commitment)
/// This pubscriptKey can be inserted into an output for a new transaction.
(String, String, String) scriptNameNew(String name) {
  final identifier = ascii.encode(name);
  validateIdentifierLength(identifier);
  final (nameOp, salt) = _buildNameNew(identifier);
  final saltHex = bytesToHex(salt);
  final commitment = bytesToHex(nameOp["commitment"] as Uint8List);
  return (nameOpToScript(nameOp), saltHex, commitment);
}

(Map<String, Object>, Uint8List) _buildNameNew(Uint8List identifier) {
  final salt = generateRandomBytes(20);
  final commitment = Digest("RIPEMD-160")
      .process(sha256Hash(Uint8List.fromList(salt + identifier)));
  return ({"op": opCodeNameNewValue, "commitment": commitment}, salt);
}
