import 'dart:convert';
import 'dart:typed_data';

import 'package:coinlib/coinlib.dart';
import 'package:namecoin/src/constants.dart';
import 'package:namecoin/src/scripts/tools.dart';
import 'package:namecoin/src/scripts/validators.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/key_derivators/api.dart';
import 'package:pointycastle/key_derivators/hkdf.dart';

/// Generate a pubScriptKey to register a new name.
///
/// Does not check if the name is already taken.
/// Returns the salt and the commitment that are necessary
/// when first updating the name from this output.
/// Returns (script, salt, commitment)
/// This pubscriptKey can be inserted into an output for a new transaction.
(String, String, String) scriptNameNew(String name, [Uint8List? privkey]) {
  final identifier = ascii.encode(name);
  validateIdentifierLength(identifier);
  final (nameOp, salt) = _buildNameNew(identifier, privkey);
  final saltHex = bytesToHex(salt);
  final commitment = bytesToHex(nameOp["commitment"] as Uint8List);
  return (nameOpToScript(nameOp), saltHex, commitment);
}

(Map<String, Object>, Uint8List) _buildNameNew(Uint8List identifier,
    [Uint8List? privkey]) {
  final Uint8List salt;
  if (privkey != null) {
    salt = saltFromPrivKey(privkey, identifier);
  } else {
    salt = generateRandomBytes(20);
  }
  final commitment = Digest("RIPEMD-160")
      .process(sha256Hash(Uint8List.fromList(salt + identifier)));
  return ({"op": opCodeNameNewValue, "commitment": commitment}, salt);
}

/// Create a salt for a NAME_NEW operation using the private key from the address on which the name op will be sent.
///
/// It allows to retrieve the salt deterministically from the mnemonic/address/name.
Uint8List saltFromPrivKey(Uint8List privkey, Uint8List identifier) {
  final hkdf = HKDFKeyDerivator(SHA256Digest());
  final info = Uint8List.fromList(ascii.encode('Namecoin Registration Salt'));
  hkdf.init(HkdfParameters(privkey, 32, identifier, info));
  final derivedKey = Uint8List(32);
  hkdf.deriveKey(null, 0, derivedKey, 0);
  return derivedKey.sublist(0, 20);
}
