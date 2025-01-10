/// Number of blocks to wait before a name operation is over and can be renewed by the owner.
const int blocksMinToRenewName = 12;

/// Number of blocks after which a name operation is expired and can be renewed by anyone.
///
/// correspond to NAME_EXPIRATION from electrum-nmc
/// https://github.com/namecoin/electrum-nmc/blob/50aa1459b2eb12ddb0b7f4fb19168019da4845d5/electrum_nmc/electrum/constants.py#L100
const int blocksNameExpiration = 36000;

/// Number of blocks after which the value of the key will resolve to 'NXDOMAIN'.
///
/// It makes the owner aware that the key/value pair will expire in a month
/// Wallets should allow the owner to renew before the semi-expiration to prevent downtime.
/// correspond to NAME_SEMI_EXPIRATION from electrum_nmc
/// https://github.com/namecoin/electrum-nmc/blob/50aa1459b2eb12ddb0b7f4fb19168019da4845d5/electrum_nmc/electrum/constants.py#L101
const int blocksNameSemiExpiration = blocksNameExpiration - (2 * 2016);

/// Average time for a block to be mined.
const int blocksTimeSeconds = 600;

/// The code used to retrieve the value of the OP for OP_NAME_NEW
/// See also [opCodeNameNewValue]
///
/// https://github.com/namecoin/electrum-nmc/blob/50aa1459b2eb12ddb0b7f4fb19168019da4845d5/electrum_nmc/electrum/names.py#L1746
/// https://pub.dev/documentation/coinlib/latest/coinlib/scriptOpNameToCode.html
const String opCodeNameNew = "1";

/// The code used to retrieve the value of the OP for OP_NAME_FIRSTUPDATE
/// See also [opCodeNameFirstUpdateValue]
///
/// https://github.com/namecoin/electrum-nmc/blob/50aa1459b2eb12ddb0b7f4fb19168019da4845d5/electrum_nmc/electrum/names.py#L1747
/// https://pub.dev/documentation/coinlib/latest/coinlib/scriptOpNameToCode.html
const String opCodeNameFirstUpdate = "2";

/// The code used to retrieve the value of the OP for OP_NAME
/// See also [opCodeNameUpdateValue]
///
/// https://github.com/namecoin/electrum-nmc/blob/50aa1459b2eb12ddb0b7f4fb19168019da4845d5/electrum_nmc/electrum/names.py#L1746
/// https://pub.dev/documentation/coinlib/latest/coinlib/scriptOpNameToCode.html
const String opCodeNameUpdate = "3";

/// OpCode value for OP_NAME_NEW
const int opCodeNameNewValue = 0x51;

/// OpCode value for OP_NAME_FIRSTUPDATE
const int opCodeNameFirstUpdateValue = 0x52;

/// OpCode value for OP_NAME_UPDATE
const int opCodeNameUpdateValue = 0x53;

/// Literal string of the name of the name operation
///
/// from electrum-nmc
/// https://github.com/namecoin/electrum-nmc/blob/50aa1459b2eb12ddb0b7f4fb19168019da4845d5/electrum_nmc/electrum/names.py#L343-L345
const String opNameNew = "name_new";
const String opNameFirstUpdate = "name_firstupdate";
const String opNameUpdate = "name_update";

/// Commitment length required
///
/// https://github.com/namecoin/electrum-nmc/blob/50aa1459b2eb12ddb0b7f4fb19168019da4845d5/electrum_nmc/electrum/names.py#L108
const int commitmentLengthRequired = 20;

/// Salt length required
///
/// https://github.com/namecoin/electrum-nmc/blob/50aa1459b2eb12ddb0b7f4fb19168019da4845d5/electrum_nmc/electrum/names.py#L114
const int saltLengthRequired = 20;

/// Name max length
///
/// https://github.com/namecoin/electrum-nmc/blob/50aa1459b2eb12ddb0b7f4fb19168019da4845d5/electrum_nmc/electrum/names.py#L122
const int nameMaxLength = 255;

/// Value max length
///
/// https://github.com/namecoin/electrum-nmc/blob/50aa1459b2eb12ddb0b7f4fb19168019da4845d5/electrum_nmc/electrum/names.py#L129
const int valueMaxLength = 520;
