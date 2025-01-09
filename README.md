
Dart library to interact with namecoin key/value, parsing and constructing fields for namecoin transactions.

## Status of developmement

**Work in Progress**

## Objective

Help integrating Namecoin key/value pair in a Dart Wallet Client.

## Features

- [x] parse namecoin data from a transaction
- [x] getter for expired/renewable state/(block|time) left
- [ ] lookup key/value from blockchain
- [ ] Construct each name of operation for new transactions

## Usage

```bash
dart pub add namecoin_tools 
```
## Example

```dart
void main() {
  // assume transaction.txData returns a raw Namecoin transaction including a name_update operation, and .height returns the block height of the transaction.
  final String txData = transaction.txData;
  final int height = transaction.height;
  // instance of NameCoinOpName constructed from the transaction.
  final nameCoinOpName = NameCoinOpName.fromTx(txData, height);
  // We can get any related values.
  expect(nameCoinOpName.op, OpName.nameUpdate);
  expect(nameCoinOpName.fullname, 'd/testsw');
  expect(nameCoinOpName.namespace, 'd');
  expect(nameCoinOpName.name, 'testsw');
  expect(nameCoinOpName.constructedName, 'testsw.bit');
  expect(nameCoinOpName.value,'{"ip":["127.0.0.1"]}');
  // hash is only present in name_new operations
  expect(() => nameCoinOpName.hash, throwsException);
  // rand is only present in name_firstupdate operations
  expect(() => nameCoinOpName.rand, throwsException);
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
