
Dart library to interact with namecoin key/value, parsing and constructing fields for namecoin transactions.

## Status of developmement

**Work in Progress**

## Objective

Help integrating Namecoin key/value pair in a Dart Wallet Client.

## Features

- [x] class to parse and retain namecoin data from a transaction
- [x] getters for formatted data
- [x] getters for expired/renewable state/(block|time) left
- [x] generate a scriptHash for requests to retrieve transactions with a name.
- [ ] filter transactions to get the most up to date key/value pair 
- [ ] construct transactions for each name of operation

## Usage

```bash
dart pub add namecoin_tools 
```
## Example

```dart
void main() {

  // prepare script hash to use with request as parameter
  final scriptHash = nameIdentifierToScriptHash('d/test');
  // get all the txs including the name.
  final txs = await client.request('blockchain.scripthash.get_history', [scriptHash]);

  // TODO: filter txs to get latest operation on the name
  tx = latest_name(txs);
  // assume transaction.txData returns a raw Namecoin transaction including a name_update operation, and .height returns the block height of the transaction.
  final String txData = tx.Data;
  final int height = tx.height;
  // instance of OpNameData constructed from the transaction.
  final nameData = opNameData.fromTx(txData, height);
  // We can get any related values.
  expect(nameData.op, OpName.nameUpdate);
  expect(nameData.fullname, 'd/testsw');
  expect(nameData.constructedName, 'testsw.bit');
  expect(nameData.value,'{"ip":["127.0.0.1"]}');
  // Check if name is expired at block height
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
