import 'package:url_launcher/url_launcher.dart';

/// redirects users to NEAR wallet for key management
/// wrapper for connected account information i.e.
class Wallet {
  String walletURL;

  Wallet(this.walletURL);
  connect(contractId, appTitle, successURL, failureURL, publicKey) async {
    String url = '$walletURL&success_url=$successURL'
        '&failure_url=$failureURL'
        '&contract_id=$contractId&public_key=ed25519:'
        '$publicKey';

    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  connectWithFullAccess(
      contractId, appTitle, successURL, failureURL, publicKey) async {
    String url = '$walletURL&success_url=$successURL'
        '&failure_url=$failureURL&public_key=ed25519:'
        '$publicKey';
    await launchUrl(Uri.parse(url));
  }

  //request transaction deposit approval from wallet
  requestDepositApproval(
      String encodedTransaction, successURL, failureURL, approveTxURL) async {
    String url =
        '${approveTxURL}transactions=${Uri.encodeComponent(encodedTransaction)}'
        '&callbackUrl=$successURL';

    await launchUrl(Uri.parse(url));
  }
}
