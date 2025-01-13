import 'dart:math';
import 'dart:typed_data';

import 'package:coinlib/coinlib.dart';
import 'package:namecoin/src/constants.dart';
import 'package:namecoin/src/scripts/validators.dart';

/// Construct the script from the name operation
///
/// correspond to name_op_script from electrum-nmc
/// https://github.com/namecoin/electrum-nmc/blob/aaa705f40276fe2933f1942dadb067cb12d7ed5b/electrum_nmc/electrum/names.py#L66
String nameOpToScript(Map<String, dynamic> nameOp) {
  String script;
  switch (nameOp["op"]) {
    case opCodeNameNewValue:
      {
        final Uint8List commitment = nameOp["commitment"] as Uint8List;
        validateCommitmentLength(commitment);
        script = '51';
        script += _pushScript(bytesToHex(commitment));
        script += '6d';
      }
    case opCodeNameFirstUpdateValue:
      {
        final Uint8List salt = nameOp["salt"];
        validateSaltLength(salt);
        validateAnyUpdateLength(nameOp);
        script = '52';
        script += _pushScript(bytesToHex(nameOp["name"]));
        script += _pushScript(bytesToHex(salt));
        script += _pushScript(bytesToHex(nameOp["value"]));
        script += '6d';
        script += '6d';
      }
    case opCodeNameUpdateValue:
      {
        validateAnyUpdateLength(nameOp);
        script = '53';
        script += _pushScript(bytesToHex(nameOp["name"]));
        script += _pushScript(bytesToHex(nameOp["value"]));
        script += '6d';
        script += '75';
      }
    default:
      throw Exception('Unknown name op: $nameOp');
  }
  return script;
}

/// Returns pushed data to the script, automatically
///
/// choosing canonical opcodes depending on the length of the data.
/// hex -> hex
/// ported from https://github.com/btcsuite/btcd/blob/fdc2bc867bda6b351191b5872d2da8270df00d13/txscript/scriptbuilder.go#L128
/// push_script from electrum-nmc
/// https://github.com/namecoin/electrum-nmc/blob/aaa705f40276fe2933f1942dadb067cb12d7ed5b/electrum_nmc/electrum/bitcoin.py#L277
String _pushScript(String data) {
  final dataBytes = hexToBytes(data);
  final len = dataBytes.length;

  // "small integer" opcodes
  if (len == 0 || len == 1 && dataBytes[0] == 0) {
    return opCodeHex("0");
  } else if (len == 1 && dataBytes[0] <= 16) {
    return bytesToHex(
        Uint8List.fromList([scriptOpNameToCode["1"]! - 1 + dataBytes[0]]));
  } else if (len == 1 && dataBytes[0] == 0x81) {
    return opCodeHex("1NEGATE");
  }
  return _opPush(len) + bytesToHex(dataBytes);
}

String _opPush(int i) {
  if (i < scriptOpNameToCode["PUSHDATA1"]!) {
    return _intToHex(i);
  } else if (i <= 0xff) {
    return opCodeHex("PUSHDATA1") + _intToHex(i, 1);
  } else if (i <= 0xffff) {
    return opCodeHex("PUSHDATA2") + _intToHex(i, 2);
  }
  return opCodeHex("PUSHDATA4") + _intToHex(1, 4);
}

/// rev_hex from electrum-nmc
/// https://github.com/namecoin/electrum-nmc/blob/aaa705f40276fe2933f1942dadb067cb12d7ed5b/electrum_nmc/electrum/bitcoin.py#L200
String _revHex(String s) {
  return bytesToHex(Uint8List.fromList(hexToBytes(s).reversed.toList()));
}

/// Converts int to little-endian hex string.
///
/// `length` is the number of bytes available
/// int_to_hex from electrum-nmc
/// https://github.com/namecoin/electrum-nmc/blob/aaa705f40276fe2933f1942dadb067cb12d7ed5b/electrum_nmc/electrum/bitcoin.py#L204
String _intToHex(int i, [int length = 1]) {
  final rangeSize = pow(256, length) as int;
  if (i < -(rangeSize ~/ 2) || i >= rangeSize) {
    throw Exception('cannot convert int $i to hex ($length bytes)');
  }
  if (i < 0) {
    i = rangeSize + i;
  }
  final hex = i.toRadixString(16);
  final s = "0" * (2 * length - hex.length) + hex;
  return _revHex(s);
}

/// script_toscripthash from electrum-nmc
/// https://github.com/namecoin/electrum-nmc/blob/aaa705f40276fe2933f1942dadb067cb12d7ed5b/electrum_nmc/electrum/bitcoin.py#L507
String scriptToScriptHash(String script) {
  final h = sha256Hash(hexToBytes(script)).sublist(0, 32);
  return bytesToHex(Uint8List.fromList(h.reversed.toList()));
}

/// Helper function to get the value of OP_CODE to Hex
String opCodeHex(String name) {
  return bytesToHex(Uint8List.fromList([scriptOpNameToCode[name]!]));
}
