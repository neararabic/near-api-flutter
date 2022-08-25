import 'package:near_api_flutter/near_api_flutter.dart';
import 'package:near_api_flutter/src/wallet_access_config.dart';
import 'package:url_launcher/url_launcher.dart';

class Wallet {
  WalletConnectionConfig walletConnectionParams;
  String walletURL;
  KeyPair keyPair;

  Wallet(this.walletURL, this.keyPair, this.walletConnectionParams);

  //account, contract, appTitle,...
  requestSignIn() async {
    String url =
        '$walletURL&success_url=${walletConnectionParams.successURL}&failure_url='
        '${walletConnectionParams.failureURL}&public_key=ed25519:${KeyStore.publicKeyToString(keyPair.publicKey)}';

    await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalNonBrowserApplication);
  }
  void requestSignInWithFullAccess() {
    //TODO
  }
}
