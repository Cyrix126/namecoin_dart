import 'dart:typed_data';

import 'package:namecoin/src/constants.dart';

/// Verify that the commitment length satisfy the requirement
///
/// Throw an exception if false.
/// correspond to validate_commitment_length from electrum-nmc
/// https://github.com/namecoin/electrum-nmc/blob/aaa705f40276fe2933f1942dadb067cb12d7ed5b/electrum_nmc/electrum/names.py#L107
void validateCommitmentLength(Uint8List commitment) {
  final len = commitment.length;
  if (len != commitmentLengthRequired) {
    throw Exception(
        'commitment length $len is not equal to requirement of $commitmentLengthRequired');
  }
}

/// Verify that the salt length satisfy the requirement
///
/// Throw an exception if false.
/// correspond to validate_commitment_length from electrum-nmc
/// https://github.com/namecoin/electrum-nmc/blob/aaa705f40276fe2933f1942dadb067cb12d7ed5b/electrum_nmc/electrum/names.py#L114
void validateSaltLength(Uint8List salt) {
  final len = salt.length;
  if (len != saltLengthRequired) {
    throw Exception(
        'salt length $len is not equal to requirement of $saltLengthRequired');
  }
}

/// Verify that name length is less than the max name length allowed
///
/// Throw an exception if false.
/// correspond to validate_identifier_length from electrum-nmc
/// https://github.com/namecoin/electrum-nmc/blob/aaa705f40276fe2933f1942dadb067cb12d7ed5b/electrum_nmc/electrum/names.py#L122
void validateIdentifierLength(Uint8List identifier) {
  final len = identifier.length;
  if (len > nameMaxLength) {
    throw Exception('identifier length $len exceeds limit of $nameMaxLength');
  }
}

/// Verify that name length is less than the max name length allowed
///
/// Throw an exception if false.
/// correspond to validate_identifier_length from electrum-nmc
/// https://github.com/namecoin/electrum-nmc/blob/aaa705f40276fe2933f1942dadb067cb12d7ed5b/electrum_nmc/electrum/names.py#L128
void validateValueLength(Uint8List value) {
  final len = value.length;
  if (len > valueMaxLength) {
    throw Exception('value length $len exceeds limit of $valueMaxLength');
  }
}

/// Verify that any update length satisfy the requirement
///
/// correspond to validate_anyupdate_length from electrum-nmc
/// https://github.com/namecoin/electrum-nmc/blob/aaa705f40276fe2933f1942dadb067cb12d7ed5b/electrum_nmc/electrum/names.py#L103
void validateAnyUpdateLength(Map<String, dynamic> nameOp) {
  validateIdentifierLength(nameOp["name"]);
  validateValueLength(nameOp["value"]);
}
