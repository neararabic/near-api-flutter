import 'package:near_api_flutter/near_api_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Wallet {
  WalletConnectionConfig walletConnectionParams;
  String walletURL;
  String approveTxURL;
  KeyPair keyPair;

  Wallet(this.walletURL, this.approveTxURL, this.keyPair,
      this.walletConnectionParams);

  //account, contract, appTitle,...
  requestSignIn() async {
    String url =
        '$walletURL&success_url=${walletConnectionParams.loginSuccessURL}&failure_url='
        '${walletConnectionParams.loginFailureURL}&contract_id=${walletConnectionParams.contract}&public_key=ed25519:${KeyStore.publicKeyToString(keyPair.publicKey)}';

    await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalNonBrowserApplication);
  }

  requestSignInWithFullAccess() {
    //TODO
  }

  //request transaction deposit approval from wallet
  requestDepositApproval(String encodedTransaction) async {
    String url =
        '${approveTxURL}transactions=${Uri.encodeComponent(encodedTransaction)}&callbackUrl=${walletConnectionParams.transactionSuccessURL}';
    await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalNonBrowserApplication);
  }
}
