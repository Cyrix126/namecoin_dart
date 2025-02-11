import 'dart:core';

import 'package:namecoin/namecoin.dart';

/// A representation of a specific namecoin data in a transaction
///
/// It will detect the type operation and throw an exception if a method is called on a wrong variant.
class OpNameData {
  /// Json data containing a name operation
  ///
  /// This is the data of "nameOp" field in the scriptPubKey field of an output.
  final Map<String, dynamic> _dataOp;

  /// block height of when the transaction has been made
  ///
  /// Allows to make the calculation about expiration
  final int height;

  /// Construct a instance of OpNameData by giving the "nameOp" data as Json
  ///
  /// See fromTx(txData) constructor to create an instance from a complete raw transaction
  /// throw an error if the data is not a correct "nameOp" data.
  /// TODO: full syntax check of the three variants
  OpNameData(this._dataOp, this.height) : assert(_dataOp["op"] != null);

  /// Takes a transaction data and a String containing a height field to create an instance of OpNameData
  ///
  /// It will automatically retrieve the opData from the tx data and the height from the tx hash.
  static OpNameData fromTx(Map<String, dynamic> txData, int height) {
    final outputs = txData["vout"] as List<dynamic>;
    for (final output in outputs) {
      final Map<String, dynamic>? dataOp = output["scriptPubKey"]["nameOp"];
      if (dataOp != null) {
        return OpNameData(dataOp, height);
      }
    }
    throw Exception(
        'The class OpNameData can not be constructed from the transaction: $txData');
  }

  /// Return the type of the name operation
  OpName get op => OpName.fromString(_dataOp["op"]!);

  /// Return the name of the key pair, excluding the namespace
  String get name {
    return fullname.replaceAll(RegExp('.*/'), '');
  }

  /// Return the interpreted name, depending on the namespace.
  ///
  /// Only d/ for .bit domains are currently supported.
  String get constructedName {
    return switch (namespace) {
      'd' => '$name.bit',
      _ => name,
    };
  }

  /// Return the namespace of the key pair, excluding the name
  String get namespace {
    final match = RegExp('.*(?=/)').firstMatch(fullname);
    if (match != null) {
      return match[0]!;
    } else {
      return '';
    }
  }

  /// Return the name space of the key pair, excluding the name
  ///
  /// Will return null if no name operation is present in the transaction.
  String get fullname {
    switch (op) {
      case OpName.nameFirstUpdate || OpName.nameUpdate:
        return _dataOp["name"]!;
      case OpName.nameNew:
        throw Exception('the operation nameNew do not have a name');
    }
  }

  /// Return the value of the key pair, not useable with nameNew
  String get value {
    switch (op) {
      case OpName.nameFirstUpdate || OpName.nameUpdate:
        return _dataOp["value"]!;
      default:
        throw Exception(
            'method called on a $op operation when only ${OpName.nameFirstUpdate} and ${OpName.nameUpdate} have a field "value"');
    }
  }

  /// Return the rand of the key pair, useable only with nameFirstUpdate
  String get rand {
    switch (op) {
      case OpName.nameFirstUpdate:
        return _dataOp["rand"]!;
      default:
        throw Exception(
            'called method rand on a $op when only ${OpName.nameFirstUpdate} has a "rand" field');
    }
  }

  /// Return the rand of the key pair, useable only with nameNew
  String get hash {
    switch (op) {
      case OpName.nameNew:
        return _dataOp["hash"]!;
      default:
        throw Exception(
            'called method rand on a $op when only ${OpName.nameNew} has a "hash" field');
    }
  }

  /// Check if a name operation in this transaction is old enough (12 blocks) to be renewed.
  ///
  /// currentHeight parameter is the current height of the Namecoin blockchain
  bool renewable(int currentHeight) {
    return (renewableBlockLeft(currentHeight) == null);
  }

  /// Number of blocks to wait before being renewable
  ///
  /// If null, it means the period of lock before being renewable is finished.
  int? renewableBlockLeft(int currentHeight) {
    final blocksLeft = (height + blocksMinToRenewName) - currentHeight;
    if (blocksLeft.isNegative || blocksLeft == 0) {
      return null;
    }
    return blocksLeft;
  }

  /// Estimated time to wait before being renewable
  ///
  /// if null, it means it is currently renewable
  int? renewableTimeLeft(int currentHeight) {
    final blocksLeft = renewableBlockLeft(currentHeight);
    if (blocksLeft != null) {
      return blocksLeft * blocksTimeSeconds;
    }
    return null;
  }

  /// Number of blocks before being (semi-)expired
  ///
  /// if null, it means it has already (semi-)expired.
  int? expiredBlockLeft(int currentHeight, [bool semi = false]) {
    final int blocksExpiration;
    if (semi) {
      blocksExpiration = blocksNameSemiExpiration;
    } else {
      blocksExpiration = blocksNameExpiration;
    }
    final blocksLeft = (height + blocksExpiration) - currentHeight;
    if (blocksLeft.isNegative || blocksLeft == 0) {
      return null;
    }
    return blocksLeft;
  }

  /// Estimated time before (semi-)expiration.
  ///
  /// if null, it means it has already (semi-)expired.
  int? expiredTimeLeft(int currentHeight, [bool semi = false]) {
    final blocksLeft = expiredBlockLeft(currentHeight, semi);
    if (blocksLeft != null) {
      return blocksLeft * blocksTimeSeconds;
    }
    return null;
  }

  /// Check if (semi-)expired
  ///
  /// It means the name will be (semi-)expired if it has not been renewed by another transaction.
  bool expired(int currentHeight, [bool semi = false]) {
    return expiredBlockLeft(currentHeight, semi) == null;
  }
}

/// Three possible variants for a name operation
enum OpName {
  nameNew,
  nameFirstUpdate,
  nameUpdate;

  /// convert a string to the corresponding variant of name operation.
  ///
  /// Throw an exception if the string is invalid.
  static OpName fromString(String value) {
    final opName = switch (value) {
      opNameNew => OpName.nameNew,
      opNameFirstUpdate => OpName.nameFirstUpdate,
      opNameUpdate => OpName.nameUpdate,
      _ => throw Exception(
          'The value \'$value\' is not valid to construct a variant of name operation.')
    };
    return opName;
  }
}
