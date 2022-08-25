
import 'package:ed25519_edwards/ed25519_edwards.dart';

class NEARConnectionConfig {
  String networkId;
  KeyPair keyPair;
  String walletUrl;
  String helperUrl;
  String explorerUrl;
  String rpcUrl;

  NEARConnectionConfig(this.networkId, this.keyPair, this.walletUrl,
      this.helperUrl, this.explorerUrl, this.rpcUrl);
}