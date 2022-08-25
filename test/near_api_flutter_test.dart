import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:near_api_flutter/near_api_flutter.dart';

void main() {
  test('adds one to input values', () {
    // network and wallet config data
    const String networkId = "testnet";
    const String walletURL = 'https://wallet.testnet.near.org/login/?';
    const String helperUrl = 'https://helper.testnet.near.org"';
    const String explorerUrl = 'https://explorer.testnet.near.org';
    const String rpcUrl = 'https://archival-rpc.testnet.near.org';
    const String globalServer =
        'https://near-transaction-serializer.herokuapp.com';
    const String nearSignInSuccessUrl = '$globalServer/success';
    const String nearSignInFailUrl = '$globalServer/failure';

    //generate keys
    KeyPair keyPair = KeyStore.newKeyPair();
    if (kDebugMode) {
      print(KeyStore.publicKeyToString(keyPair.publicKey));
    }

    assert(keyPair.privateKey.bytes.isNotEmpty);
    assert(keyPair.publicKey.bytes.isNotEmpty);

    //wallet login
    WalletConnectionConfig walletConnectionParam = WalletConnectionConfig(
        contract: "friendbook.msaudi.testnet",
        appTitle: "FriendBook",
        successURL: nearSignInSuccessUrl,
        failureURL: nearSignInFailUrl);

    Wallet wallet = Wallet(walletURL, keyPair, walletConnectionParam);
    wallet.requestSignIn();
    // wallet.requestSignInWithFullAccess();
    //
    // NEARConnectionConfig nearConnectionConfig = (
    //     networkId, keyPair, walletURL, helperUrl, explorerUrl, rpcUrl);
    //
    // String contractId = "friendbook.msaudi.testnet";
    // Contract contract = Contract(contractId, nearConnectionConfig);
    // contract.call("writeSomething", '{"":"", "":"", "":""}');
    // contract.view("writeSomething", '{"":"", "":"", "":""}');
    //
    // Account mohammedAccount = Account("msaudi.testnet");
    // mohammedAccount.sendTokens(23, "mhassanist.testnet");
  });
}
