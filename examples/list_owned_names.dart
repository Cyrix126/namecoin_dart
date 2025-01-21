import 'dart:io';
import 'dart:typed_data';

import 'package:args/args.dart';
import 'package:coinlib/coinlib.dart';
import 'package:crypto/crypto.dart';
import 'package:electrum_adapter/electrum_adapter.dart';
import 'package:namecoin/namecoin.dart';

// copied from
// https://github.com/cypherstack/stack_wallet/blob/cb11d58c47567698cb77805a844c27f6e653f01e/lib/wallets/crypto_currency/coins/namecoin.dart#L182
final network = Network(
  wifPrefix: 0xb4, // From 180.
  p2pkhPrefix: 0x34, // From 52.
  p2shPrefix: 0x0d, // From 13.
  privHDPrefix: 0x0488ade4,
  pubHDPrefix: 0x0488b21e,
  bech32Hrp: "nc",
  messagePrefix: '\x18Namecoin Signed Message:\n',
  minFee: BigInt.from(1), // Not used in stack wallet currently
  minOutput: BigInt.from(1), // Not used in stack wallet currently
  feePerKb: BigInt.from(1), // Not used in stack wallet currently
);

void main(List<String> arguments) async {
  final parser = ArgParser();
  parser.addOption('address', mandatory: true);
  final args = parser.parse(arguments);

  final sh = addressToScriptHash(address: args.option('address')!);

  // create client to namecoin node
  final client = await ElectrumClient.connect(
    host: 'namecoin.stackwallet.com',
    port: 57002,
  );

  final int currentHeight =
      (await client.request('blockchain.headers.subscribe', []))["height"];
  // get all txs for this address.
  final List<dynamic> txsHash =
      await client.request('blockchain.scripthash.get_history', [sh]);
  List<OpNameData> nameDatas = [];
  for (final txHash in txsHash) {
    // get the tx
    final tx = await client.getTransaction(txHash["tx_hash"]);
    try {
      final nameData = OpNameData.fromTx(tx, txHash["height"]);
      if (!nameData.expired(currentHeight)) {
        nameDatas.add(nameData);
      }
    } catch (_) {}
  }
  await client.close();
  if (nameDatas.isNotEmpty) {
    for (final nameData in nameDatas) {
      print(nameData.constructedName);
    }
  }
  exit(0);
}

// copied from
// https://github.com/cypherstack/stack_wallet/blob/cb11d58c47567698cb77805a844c27f6e653f01e/lib/wallets/crypto_currency/intermediate/bip39_hd_currency.dart#L35
String addressToScriptHash({required String address}) {
  try {
    final addr = Address.fromString(address, network);
    return convertBytesToScriptHash(addr.program.script.compiled);
  } catch (e) {
    rethrow;
  }
}

// copied from
// https://github.com/cypherstack/stack_wallet/blob/cb11d58c47567698cb77805a844c27f6e653f01e/lib/wallets/crypto_currency/intermediate/bip39_hd_currency.dart#L63
String convertBytesToScriptHash(Uint8List bytes) {
  final hash = sha256.convert(bytes.toList(growable: false)).toString();

  final chars = hash.split("");
  final List<String> reversedPairs = [];
  // TODO find a better/faster way to do this?
  int i = chars.length - 1;
  while (i > 0) {
    reversedPairs.add(chars[i - 1]);
    reversedPairs.add(chars[i]);
    i -= 2;
  }
  return reversedPairs.join("");
}
