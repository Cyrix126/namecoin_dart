import 'dart:convert';
import 'dart:typed_data';

import 'package:coinlib/coinlib.dart';
import 'package:namecoin/namecoin.dart';

/// Takes an hex field of a pubScriptKey and decode it to a Map`<`String, String> representing an op_name.
//
/// The result is directly useable to construct an [OpNameData] instance.
/// The "hash" correspond to the commitment and "rand" to the salt. This value are named this way here
/// to remain compatible with the data returned from a namecoin node.
Map<String, String> parsePubScriptKeyHex(String hex) {
  final bytes = hexToBytes(hex);
  final decoded = _scriptGetOp(bytes);
  switch (decoded[0].$1) {
    case opCodeNameNewValue:
      return {"op": opNameNew, "hash": bytesToHex(decoded[1].$2)};
    case opCodeNameFirstUpdateValue:
      return {
        "op": opNameFirstUpdate,
        "name": ascii.decode(decoded[1].$2.toList()),
        "rand": bytesToHex(decoded[2].$2),
        "value": ascii.decode(decoded[3].$2.toList())
      };
    case opCodeNameUpdateValue:
      return {
        "op": opNameUpdate,
        "name": ascii.decode(decoded[1].$2.toList()),
        "value": ascii.decode(decoded[3].$2.toList())
      };
    default:
      throw Exception('This scriptPubKey does not contains an OP_NAME');
  }
}

List<(int, Uint8List, int)> _scriptGetOp(Uint8List bytes) {
  List<(int, Uint8List, int)> result = [];
  int i = 0;

  while (i < bytes.length) {
    List<int> vch = [];
    final opCode = bytes[i];
    i++;
    // TODO: use op code as constant with switch ?
    if (opCode <= scriptOpNameToCode["PUSHDATA4"]!) {
      int nSize = opCode;
      if (opCode == scriptOpNameToCode["PUSHDATA1"]!) {
        try {
          nSize = bytes[i];
        } on IndexError {
          throw Exception('Malformed bitcoin script');
        }
        i++;
      } else if (opCode == scriptOpNameToCode["PUSHDATA2"]!) {
        try {
          //
          nSize = bytes.buffer.asByteData(i, 2).buffer.asUint16List()[0];
          // nSize = (bytes[i] + (bytes[i + 1] << 8));
        } catch (e) {
          Exception('Malformed bitcoin script');
        }
        i += 2;
      } else if (opCode == scriptOpNameToCode["PUSHDATA4"]!) {
        try {
          nSize = bytes.buffer.asByteData(i, 4).buffer.asUint32List()[0];
          // nSize = bytes.buffer.asByteData(i, 4).getUint32(0);
        } catch (e) {
          Exception('Malformed bitcoin script');
        }
        i += 4;
      }
      vch = bytes.sublist(i, i + nSize);
      i += nSize;
    }
    result.add((opCode, Uint8List.fromList(vch), i));
  }
  return result;
}
