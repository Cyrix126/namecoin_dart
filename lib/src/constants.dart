/// Number of blocks to wait before a name operation is over and can be renewed by the owner.
const int blocksMinToRenewName = 12;

/// Number of blocks after which a name operation is expired and can be renewed by anyone.
const int blocksNameExpiration = 36000;

/// Number of blocks after which the value of the key will resolve to NXDOMAIN.
/// It makes the owner aware that the key/value pair will expire in a month
/// Wallets should allow the owner to renew before the semi-expiration to prevent downtime.
const int blocksNameSemiExpiration = blocksNameExpiration - (2 * 2016);

/// Average time for a block to be mined.
const int blocksTimeSeconds = 600;
