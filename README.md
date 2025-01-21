
Low level Dart library to interact with namecoin key/value, parsing and constructing fields for namecoin transactions.

## Status of developmement

**Beta Release**  
Not tested in production.

## Objective

Help integrating Namecoin key/value pair in a Dart Wallet Client.

## Features

- [x] class to parse and retain namecoin data from a transaction
- [x] getters for formatted data
- [x] getters for expired/renewable state/(block|time) left
- [x] generate a scriptHash for requests to retrieve txid with a name.
- [x] decode from scriptPubKey
- [x] construct transactions for each name of operation
  - [x] name_new
  - [x] name_firstupdate
  - [x] name_update
- [ ] full example

## Usage

```bash
dart pub add namecoin_tools 
```
## Example

```dart
void main() {

  // prepare script hash to use with request as parameter
  final String scriptHash = nameIdentifierToScriptHash('d/testsw');
  // get all the txids including the name using 'blockchain.scripthash.get_history' method with the scriptHash as parameter
  final Iterable<Map<String, dynamic>> txIds = await client.scriptHashGetHistory([scriptHash]);
  // keep only the most up to date (highest height), it will be the latest.
  final Map<String, dynamic> txId = txIds.last;
  // get the hash of the txid
  final String txHash = txId["tx_hash"];
  final int height = txId.["height"];
  // fetch the tx details using 'blockchain.transaction.get' method and txHash as parameter.
  final Map<String, dynamic> txData = await client.getTransaction(txHash);
  // instance of OpNameData constructed from the transaction.
  final nameData = opNameData.fromTx(txData, height);
  // We can get any related values.
  expect(nameData.op, OpName.nameUpdate);
  expect(nameData.fullname, 'd/testsw');
  expect(nameData.constructedName, 'testsw.bit');
  expect(nameData.value,'{"ip":["127.0.0.1"]}');
  // Check if name is expired at block height
  // You must retrieve current height of blockchain using your client.
  final current_height = client.blockchain_height;
  expect(nameData.expired(current_height), false);
  // hash is only present in name_new operations
  expect(() => nameData.hash, throwsException);
  // rand is only present in name_firstupdate operations
  expect(() => nameData.rand, throwsException);
}
```
## Bug Reporting

Open an [issue](https://github.com/Cyrix126/dart_namecoin_tools/issues)

## Contributing

Fork the [repository](https://github.com/Cyrix126/dart_namecoin_tools) and make a PR

## Security

Current version is not ready for production.  
Security disclosure can be made by email at [cyrix126@baermai.fr](mail:cyrix126@baermail.fr) using this public key:

```
-----BEGIN PGP PUBLIC KEY BLOCK-----

mDMEZ31sahYJKwYBBAHaRw8BAQdAgtSYnoVBJpkcub14GB1guG9EF4hyFgnaE7Sc
by0bbCW0H0N5cml4MTI2IDxjeXJpeDEyNkBiYWVybWFpbC5mcj6IkwQTFgoAOxYh
BCbf3Q4Kpfi5BGKBCJZiLwmgEOVtBQJnfWxqAhsDBQsJCAcCAiICBhUKCQgLAgQW
AgMBAh4HAheAAAoJEJZiLwmgEOVtvL8BAKookXF3nfUQa5KrbtUtP6L3aJ81kAXr
lXrJ65ZK9W0hAP4pl+OhYsrszjxfS8Beuk5de8dbZPYnX/GPlcdZLkr0A7g4BGd9
bGoSCisGAQQBl1UBBQEBB0DpnhgJ8g0KD/arA0NFMF7McyaHhuC1BVcvhQyir+L2
NAMBCAeIeAQYFgoAIBYhBCbf3Q4Kpfi5BGKBCJZiLwmgEOVtBQJnfWxqAhsMAAoJ
EJZiLwmgEOVtbZoA/15/1NDnQoUjRP05YGVmmHkKRue40sFYohQa8d+db6wsAQCg
v2q+6Fd1mBZcT5wCl3gFqJOthYrKvjYOppUkFIrCCw==
=QVXA
-----END PGP PUBLIC KEY BLOCK-----
```
## Documentation


Documentation can be generated locally:
```bash
dart doc .
```
## License

GNU GPL v3
