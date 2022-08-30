import 'package:flutter/foundation.dart';
import 'package:near_api_flutter/near_api_flutter.dart';

class NEARTester {
  static loginWithLimitedAccess(walletURL, contractId, accountId, appTitle,
      signInSuccessUrl, signInFailureUrl) {
    // Generate Keys
    var keyPair = KeyStore.newKeyPair();
    var publicKey = KeyStore.publicKeyToString(keyPair.publicKey);

    // Open near wallet in default browser
    var wallet = Wallet(walletURL);

    wallet.connectLimitedAccess(
        contractId, appTitle, signInSuccessUrl, signInFailureUrl, publicKey);

    Account account = Account(
        accountId: accountId,
        keyPair: keyPair,
        provider: NEARTestNetRPCProvider());

    return account; //connected account
  }

  static loginWithFullAccess(walletURL, contractId, accountId, appTitle,
      signInSuccessUrl, signInFailureUrl) {
    // Generate Keys
    var keyPair = KeyStore.newKeyPair();
    var publicKey = KeyStore.publicKeyToString(keyPair.publicKey);

    // Open near wallet in default browser
    var wallet = Wallet(walletURL);

    wallet.connectWithFullAccess(
        contractId, appTitle, signInSuccessUrl, signInFailureUrl, publicKey);

    Account account = Account(
        accountId: accountId,
        keyPair: keyPair,
        provider: NEARTestNetRPCProvider());

    return account; //connected account
  }

  //contract holds the account to use for calling
  static callMethodLimitedAccess(Contract contract, String method, args) async {
    var result = await contract.callFunction(method, args);
    return result;
  }

  //contract holds the account to use for calling - account must have a full access key
  static callMethodFullAccess(Contract contract, String method, args) async {
    var result = await contract.callFunction(method, args);
    return result;
  }

  static callMethodFullAccessWithDeposit(Contract contract, String method, args, nearAmount) async {
    var result = await contract.callFunction(method, args, nearAmount);
    return result;
  }

  static callMethodLimitedAccessWithDeposit(Contract contract, String method, String walletURL, args, nearAmount, successUrl, failureUrl, approvalURL) async {
    // Open near wallet in default browser
    var wallet = Wallet(walletURL);

    var result = await contract.callFunctionWithDeposit(method, args, wallet, nearAmount, successUrl, failureUrl, approvalURL);
    return result;
  }

  static transferNear(Account account, nearAmount, receiver) async {
    var result = await account.sendTokens(nearAmount, receiver);
    return result;

  }
}
