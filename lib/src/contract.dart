import 'dart:typed_data';
import 'package:near_api_flutter/near_api_flutter.dart';
import 'package:near_api_flutter/src/constants.dart';
import 'package:near_api_flutter/src/models/access_key.dart';
import 'package:near_api_flutter/src/models/action_types.dart';
import 'package:near_api_flutter/src/models/transaction_dto.dart';
import 'package:near_api_flutter/src/transaction_api/rpc_providers.dart';
import 'package:near_api_flutter/src/transaction_api/transaction_manager.dart';

///represents a contract entity: contractId, view methods, and change methods
class Contract {
  String contractId;
  Account callerAccount;//account to sign change method transactions

  Contract(this.contractId, this.callerAccount);


  Future<String> callFunction(String functionName, String functionArgs,
      [double nearAmount = 0.0, int gasFees = Constants.defaultGas]) async {
    AccessKey accessKey = await callerAccount.getAccessKey();

    // Create Transaction
    accessKey.nonce++;
    String publicKey = KeyStore.publicKeyToString(callerAccount.keyPair.publicKey);

    Transaction transaction = Transaction(
        actionType: ActionType.functionCall,
        signer: callerAccount.accountId,
        publicKey: publicKey,
        nearAmount: nearAmount.toStringAsFixed(12),
        gasFees: gasFees,
        receiver: contractId,
        methodName: functionName,
        methodArgs: functionArgs,
        accessKey: accessKey);

    // Serialize Transaction
    Uint8List serializedTransaction =
    TransactionManager.serializeFunctionCallTransaction(transaction);
    Uint8List hashedSerializedTx =
    TransactionManager.toSHA256(serializedTransaction);

    // Sign Transaction
    Uint8List signature = TransactionManager.signTransaction(
        callerAccount.keyPair.privateKey, hashedSerializedTx);

    // Serialize Signed Transaction
    Uint8List serializedSignedTransaction =
    TransactionManager.serializeSignedFunctionCallTransaction(transaction, signature);
    String encodedTransaction =
    TransactionManager.encodeSerialization(serializedSignedTransaction);

    // Broadcast Transaction
    return await callerAccount.provider
        .broadcastTransaction(encodedTransaction);
  }

  Future<String> callFunctionWithDeposit(
      String methodName, String methodArgs, Wallet wallet, double nearAmount, successURL, failureURL, approvalURL,
      [int gasFees = Constants.defaultGas]) async {
    AccessKey accessKey = await callerAccount.getAccessKey();

    // Create Transaction
    accessKey.nonce++;
    String publicKey = KeyStore.publicKeyToString(callerAccount.keyPair.publicKey);

    Transaction transaction = Transaction(
        actionType: ActionType.functionCall,
        signer: callerAccount.accountId,
        publicKey: publicKey,
        nearAmount: nearAmount.toStringAsFixed(12),
        gasFees: gasFees,
        receiver: contractId,
        methodName: methodName,
        methodArgs: methodArgs,
        accessKey: accessKey);
    // Serialize Transaction
    Uint8List serializedTransaction =
    TransactionManager.serializeFunctionCallTransaction(transaction);

    // Sign with wallet if there is a deposit
    String transactionEncoded =
    TransactionManager.encodeSerialization(serializedTransaction);
    wallet.requestDepositApproval(transactionEncoded, successURL, failureURL,approvalURL);
    return "Please follow wallet to approve transaction";
  }

  Future<String> viewFunction(String functionName, String functionArgs,
      [double nearAmount = 0.0, int gasFees = Constants.defaultGas]) async {
    return callFunction(functionName, functionArgs, nearAmount, gasFees);
  }

}
