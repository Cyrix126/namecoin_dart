import 'package:namecoin/namecoin.dart';
import 'package:test/test.dart';

import 'parsing_tx_test.dart';

const int heightNameNew = 753547;
const int heightJustAfterNameNew = heightNameNew + 1;
const int heightAfterRenewableNameNew = heightNameNew + blocksMinToRenewName;
const int heightSemiExpiredNameNew = heightNameNew + blocksNameSemiExpiration;
const int heightExpiredNameNew = heightNameNew + blocksNameExpiration;

/// Tests to check that the calculations of renewable/expired state/block left/time left are valid.
/// Only one type of name operation is tested because the rules are the same for all.
void main() {
  final opNameData = OpNameData.fromTx(rawTxNameNew, txHashNameNew);
  group("Calculations of renewable", () {
    test("Calculations of renewable state", () {
      expect(opNameData.renewable(heightNameNew), false);
      expect(opNameData.renewable(heightJustAfterNameNew), false);
      expect(opNameData.renewable(heightAfterRenewableNameNew), true);
      expect(opNameData.renewable(heightSemiExpiredNameNew), true);
      expect(opNameData.renewable(heightExpiredNameNew), true);
    });

    test("Calculations of block left to be renewable", () {
      expect(
          opNameData.renewableBlockLeft(heightNameNew), blocksMinToRenewName);
      expect(opNameData.renewableBlockLeft(heightJustAfterNameNew),
          blocksMinToRenewName - 1);
      expect(opNameData.renewableBlockLeft(heightAfterRenewableNameNew), null);
      expect(opNameData.renewableBlockLeft(heightSemiExpiredNameNew), null);
      expect(opNameData.renewableBlockLeft(heightExpiredNameNew), null);
    });
    test("Calculations of time left to be renewable", () {
      expect(opNameData.renewableTimeLeft(heightNameNew),
          blocksMinToRenewName * blocksTimeSeconds);
      expect(opNameData.renewableTimeLeft(heightJustAfterNameNew),
          (blocksMinToRenewName - 1) * blocksTimeSeconds);
      expect(opNameData.renewableTimeLeft(heightAfterRenewableNameNew), null);
      expect(opNameData.renewableTimeLeft(heightSemiExpiredNameNew), null);
      expect(opNameData.renewableTimeLeft(heightExpiredNameNew), null);
    });
  });
  group("Calculations of expiration", () {
    test("Calculations of expired state", () {
      expect(opNameData.expired(heightNameNew), false);
      expect(opNameData.expired(heightJustAfterNameNew), false);
      expect(opNameData.expired(heightAfterRenewableNameNew), false);
      expect(opNameData.expired(heightSemiExpiredNameNew), false);
      expect(opNameData.expired(heightExpiredNameNew), true);
    });
    test("Calculations of block left to be expired", () {
      expect(opNameData.expiredBlockLeft(heightNameNew), blocksNameExpiration);
      expect(opNameData.expiredBlockLeft(heightJustAfterNameNew),
          blocksNameExpiration - 1);
      expect(opNameData.expiredBlockLeft(heightAfterRenewableNameNew),
          heightExpiredNameNew - heightAfterRenewableNameNew);
      expect(opNameData.expiredBlockLeft(heightSemiExpiredNameNew),
          heightExpiredNameNew - heightSemiExpiredNameNew);
      expect(opNameData.expiredBlockLeft(heightExpiredNameNew), null);
    });
    test("Calculations of time left to be expired", () {
      expect(opNameData.expiredTimeLeft(heightNameNew),
          blocksNameExpiration * blocksTimeSeconds);
      expect(opNameData.expiredTimeLeft(heightJustAfterNameNew),
          (blocksNameExpiration - 1) * blocksTimeSeconds);
      expect(
          opNameData.expiredTimeLeft(heightAfterRenewableNameNew),
          (heightExpiredNameNew - heightAfterRenewableNameNew) *
              blocksTimeSeconds);
      expect(
          opNameData.expiredTimeLeft(heightSemiExpiredNameNew),
          (heightExpiredNameNew - heightSemiExpiredNameNew) *
              blocksTimeSeconds);
      expect(opNameData.expiredTimeLeft(heightExpiredNameNew), null);
    });
  });
}
