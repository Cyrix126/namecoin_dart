import 'package:namecoin/namecoin.dart';
import 'package:test/test.dart';

const String txHashNameNew =
    '{"tx_hash":"6fff969eca7183cbc9a11a1afaad1c0cb3765e18c3fad80fac87c1004237cd79","height":753547,"address":"nc1qtcrrghd7h4asm2fhatqej3xlkqw7ygcyp8fveg"}';

const String rawTxNameNew =
    '{"txid":"6fff969eca7183cbc9a11a1afaad1c0cb3765e18c3fad80fac87c1004237cd79","hash":"6f34650a7e6f498f4e4b9c33a9c1d378470c04f553c8b241b1609ef126cbc5be","version":28928,"size":245,"vsize":164,"weight":653,"locktime":753546,"vin":[{"txid":"3c7dfe15e55dc3cb6912a728c721b7fab541ef317b9796610fd6ecc2c0eca0ae","vout":0,"scriptSig":{"asm":"","hex":""},"txinwitness":["30440220393ef31bf9ee6afddb555f05a60d764bc4a83934a15132ba7b9dea662e4043f302206c08da153021cd061cd9b318f3b9aa131556ef00205ec17682514e790360ea6901","03a955c8ecee477866a9be19ef6d4cc88ad1d6f6db6281ade59907dcdadd001f34"],"sequence":4294967293}],"vout":[{"value":0.015,"n":0,"scriptPubKey":{"nameOp":{"op":"name_new","hash":"ad52101edc97f205ced33f67cf319f97eb635470"},"asm":"OP_NAME_NEW ad52101edc97f205ced33f67cf319f97eb635470 OP_2DROP 0 5e06345dbebd7b0da937eac19944dfb01de22304","hex":"5114ad52101edc97f205ced33f67cf319f97eb6354706d00145e06345dbebd7b0da937eac19944dfb01de22304","address":"nc1qtcrrghd7h4asm2fhatqej3xlkqw7ygcyp8fveg","type":"witness_v0_keyhash"}},{"value":1.984834,"n":1,"scriptPubKey":{"asm":"0 30cf5a00397334d127d1ff4e69f50fb9de3954a4","hex":"001430cf5a00397334d127d1ff4e69f50fb9de3954a4","address":"nc1qxr845qpewv6dzf73la8xnag0h80rj49yvvqv92","type":"witness_v0_keyhash"}}],"blockhash":"6072f18035236b228bfebcedde49526b42f71286d6da645e55f4920a2b507129","confirmations":6,"time":1736249042,"blocktime":1736249042}';

const String txHashFirstUpdate =
    '{"tx_hash":"4e1ac13f0991dd79d8e9140373a144256b00b3b8b59e4e04f47b1458283f115d","height":753560,"address":"nc1qtcrrghd7h4asm2fhatqej3xlkqw7ygcyp8fveg"}';

const String rawTxNameFirstUpdate =
    '{"txid":"4e1ac13f0991dd79d8e9140373a144256b00b3b8b59e4e04f47b1458283f115d","hash":"6137653835d59460c8a2e1857c5f08be41183c5b8952cbf3945d2f6298015360","version":28928,"size":343,"vsize":262,"weight":1045,"locktime":753546,"vin":[{"txid":"6fff969eca7183cbc9a11a1afaad1c0cb3765e18c3fad80fac87c1004237cd79","vout":0,"scriptSig":{"asm":"","hex":""},"txinwitness":["304402203511b42f7acd65b9d66a58b996d063d4916565ade4a7395d888255f4c061f884022035f9ac56dca228620de095a64058681ddb7b202a493fa6d29ffd77cd357718d101","0227760b6ef525d09ad883f764cab3bbe514617a3057927e7712a9dec46a7ad852"],"sequence":4294967293}],"vout":[{"value":0.004735,"n":0,"scriptPubKey":{"asm":"0 c51ca14ac8e19c11a51d9b9c00b93655bda37ede","hex":"0014c51ca14ac8e19c11a51d9b9c00b93655bda37ede","address":"nc1qc5w2zjkguxwprfganwwqpwfk2k76xlk76cn7dw","type":"witness_v0_keyhash"}},{"value":0.01,"n":1,"scriptPubKey":{"nameOp":{"op":"name_firstupdate","name":"d/testsw","name_encoding":"ascii","value":"{\\"ip\\":[\\"188.114.97.2\\",\\"188.114.96.2\\"],\\"ip6\\":[\\"2a06:98c1:3121::2\\",\\"2a06:98c1:3120::2\\"]}","value_encoding":"ascii","rand":"fde80a79d760799ee20a3bba342ce784c4354a07"},"asm":"OP_NAME_FIRSTUPDATE 642f746573747377 fde80a79d760799ee20a3bba342ce784c4354a07 7b226970223a5b223138382e3131342e39372e32222c223138382e3131342e39362e32225d2c22697036223a5b22326130363a393863313a333132313a3a32222c22326130363a393863313a333132303a3a32225d7d OP_2DROP OP_2DROP 0 dd26b763361559fd39989907c21d2a15d7fb5057","hex":"5208642f74657374737714fde80a79d760799ee20a3bba342ce784c4354a074c567b226970223a5b223138382e3131342e39372e32222c223138382e3131342e39362e32225d2c22697036223a5b22326130363a393863313a333132313a3a32222c22326130363a393863313a333132303a3a32225d7d6d6d0014dd26b763361559fd39989907c21d2a15d7fb5057","address":"nc1qm5ntwcekz4vl6wvcnyruy8f2zhtlk5zhvushyn","type":"witness_v0_keyhash"}}],"blockhash":"19dc02369606f8283f2811e4b273c95d1e262eda8c5dfb5eb2c64cf2b4401556","confirmations":7,"time":1736260489,"blocktime":1736260489}';

const String txHashNameUpdate =
    '{"tx_hash": "a05095512d4a210b14a2dd140277b8af1f5f4bd110858e7ca1c6b8c0f1eace89", "height": 753573, "address": "nc1qc5w2zjkguxwprfganwwqpwfk2k76xlk76cn7dw"}';

const String rawTxNameUpdate =
    '{"txid":"a05095512d4a210b14a2dd140277b8af1f5f4bd110858e7ca1c6b8c0f1eace89","hash":"106c2cad027a58ea4f024c3d52efb3282a9fcc60538d0660b5b40cde9c272a0c","version":28928,"size":470,"vsize":308,"weight":1232,"locktime":753572,"vin":[{"txid":"4e1ac13f0991dd79d8e9140373a144256b00b3b8b59e4e04f47b1458283f115d","vout":0,"scriptSig":{"asm":"","hex":""},"txinwitness":["304402204514d4131710b9d75b11aece72d1d28ec2341ed58d0e60970455b1a991de89ab0220251082ff0b2a909dd10884bff037b2b0cade762b1cfac2ce6931223d0747f39601","03f96ba551cb99a385295816a3a7b188966f5a7418e0f2569817444e6059992a81"],"sequence":4294967293},{"txid":"4e1ac13f0991dd79d8e9140373a144256b00b3b8b59e4e04f47b1458283f115d","vout":1,"scriptSig":{"asm":"","hex":""},"txinwitness":["3044022062fe55c2eb94c3397fb5e8fef5f21e33c5369e5dd4b3c48bf14089411f944bd9022066bcc80c80d7b0290d38b7375b7625a44e4e3a2e38ba2d2bd69596e223dea64201","026ccea72802318c33de84f80942a97222e3c4aed429508942f0f12e66425057a2"],"sequence":4294967293}],"vout":[{"value":0.004422,"n":0,"scriptPubKey":{"asm":"0 a4f09824781817b9c0ee8795192b200189aef636","hex":"0014a4f09824781817b9c0ee8795192b200189aef636","address":"nc1q5ncfsfrcrqtmns8ws723j2eqqxy6aa3k0wllqm","type":"witness_v0_keyhash"}},{"value":0.01,"n":1,"scriptPubKey":{"nameOp":{"op":"name_update","name":"d/testsw","name_encoding":"ascii","value":"{\\"ip\\":[\\"188.114.97.2\\",\\"188.114.96.2\\"],\\"ip6\\":[\\"2a06:98c1:3121::2\\",\\"2a06:98c1:3120::2\\"]}","value_encoding":"ascii"},"asm":"OP_NAME_UPDATE 642f746573747377 7b226970223a5b223138382e3131342e39372e32222c223138382e3131342e39362e32225d2c22697036223a5b22326130363a393863313a333132313a3a32222c22326130363a393863313a333132303a3a32225d7d OP_2DROP OP_DROP 0 1ace3054b2449e7ca09cd1f61fab7950e1e4f85a","hex":"5308642f7465737473774c567b226970223a5b223138382e3131342e39372e32222c223138382e3131342e39362e32225d2c22697036223a5b22326130363a393863313a333132313a3a32222c22326130363a393863313a333132303a3a32225d7d6d7500141ace3054b2449e7ca09cd1f61fab7950e1e4f85a","address":"nc1qrt8rq49jgj08egyu68mpl2me2rs7f7z62f54u5","type":"witness_v0_keyhash"}}]}';

void main() {
  /// Tests to check that a class OpNameData constructed from transactions return the correct results.
  group('Parsing a raw transaction', () {
    test("newName", () {
      final opNameData = OpNameData.fromTx(rawTxNameNew, txHashNameNew);
      expect(opNameData.op, OpName.nameNew);
      expect(opNameData.hash, 'ad52101edc97f205ced33f67cf319f97eb635470');

      expect(() => opNameData.rand, throwsException);
      expect(() => opNameData.fullname, throwsException);
      expect(() => opNameData.namespace, throwsException);
      expect(() => opNameData.name, throwsException);
      expect(() => opNameData.value, throwsException);
      expect(() => opNameData.constructedName, throwsException);
    });
    test("newFirstUpdate", () {
      final opNameData =
          OpNameData.fromTx(rawTxNameFirstUpdate, txHashFirstUpdate);
      expect(opNameData.op, OpName.nameFirstUpdate);
      expect(opNameData.rand, 'fde80a79d760799ee20a3bba342ce784c4354a07');
      expect(opNameData.fullname, 'd/testsw');
      expect(opNameData.namespace, 'd');
      expect(opNameData.name, 'testsw');
      expect(opNameData.value,
          '{"ip":["188.114.97.2","188.114.96.2"],"ip6":["2a06:98c1:3121::2","2a06:98c1:3120::2"]}');
      expect(opNameData.constructedName, 'testsw.bit');
      expect(opNameData.renewable(753562), false);
      expect(opNameData.renewable(753673), true);
      expect(() => opNameData.hash, throwsException);
    });
    test("nameUpdate", () {
      final opNameData = OpNameData.fromTx(rawTxNameUpdate, txHashNameUpdate);
      expect(opNameData.op, OpName.nameUpdate);
      expect(opNameData.fullname, 'd/testsw');
      expect(opNameData.namespace, 'd');
      expect(opNameData.name, 'testsw');
      expect(opNameData.value,
          '{"ip":["188.114.97.2","188.114.96.2"],"ip6":["2a06:98c1:3121::2","2a06:98c1:3120::2"]}');
      expect(opNameData.constructedName, 'testsw.bit');
      expect(opNameData.renewable(753575), false);
      expect(opNameData.renewable(753593), true);
      expect(() => opNameData.hash, throwsException);
      expect(() => opNameData.rand, throwsException);
    });
  });
}
