import 'dart:io';

import 'package:args/args.dart';
import 'package:electrum_adapter/electrum_adapter.dart';
import 'package:namecoin/namecoin.dart';

void main(List<String> arguments) async {
  // parse arguments
  final parser = ArgParser();
  parser.addOption('name', mandatory: true);
  final args = parser.parse(arguments);
  final name = args.option('name')!;

  // create client to namecoin node
  final client = await ElectrumClient.connect(
    host: 'namecoin.stackwallet.com',
    port: 57002,
  );

  // search if name already exist.
  final shShow = nameIdentifierToScriptHash(name);
  final List<dynamic> txWithName =
      await client.request('blockchain.scripthash.get_history', [shShow]);

  if (txWithName.isNotEmpty) {
    // takes the height of the most recent one.
    final txHeight = txWithName.last["height"];
    final txHash = txWithName.last["tx_hash"];

    // get the current height of the blockchain to check if reserved name is expired.
    final int currentHeight =
        (await client.request('blockchain.headers.subscribe', []))["height"];
    final tx = await client.getTransaction(txHash);
    final opNameData = OpNameData.fromTx(tx, txHeight);
    if (opNameData.expired(currentHeight)) {
      print('the name ${opNameData.constructedName} is expired');
    } else {
      print(
          'the name ${opNameData.constructedName} is valid and it\'s value is: ${opNameData.value}');
    }
  } else {
    print('the name $name does not exist');
  }
  await client.close();
  exit(0);
}
