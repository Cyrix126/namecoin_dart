/// An easy to use library to interact with Namecoins key/value.
///
/// See README.md to get started.
library;

/// class OpNameData to inspect OP_NAME data
export 'src/op_name_data.dart';

/// Constants specific to Namecoin blockchain
export 'src/constants.dart';

/// Generate scriptPubKey for name_show request
export 'src/scripts/show.dart';

/// Generate scriptPubKey for NAME_NEW tx
export 'src/scripts/name_op/new.dart';

/// Generate scriptPubKey for NAME_FIRSTUPDATE tx
export 'src/scripts/name_op/firstupdate.dart';

/// Generate scriptPubKey for NAME_UPDATE tx
export 'src/scripts/name_op/update.dart';

/// Parse a pubscriptPubKey hex for OP_NAME
export 'src/scripts/parsing.dart';
