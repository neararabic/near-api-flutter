import 'dart:typed_data';
import 'package:near_api_flutter/near_api_flutter.dart';
import 'package:near_api_flutter/src/constants.dart';
import 'package:near_api_flutter/src/models/access_key.dart';
import 'package:near_api_flutter/src/models/transaction_dto.dart';
import 'package:near_api_flutter/src/transaction_api/near_rpc_api.dart';
import 'package:near_api_flutter/src/transaction_api/transaction_manager.dart';

class Contract {
  String contractId;
  NEARConnectionConfig nearConnectionConfig;
  Contract(this.contractId, this.nearConnectionConfig);

  Future<String> call(String methodName, String methodArgs,
      [int gasFees = Constants.defaultGas]) async {
    TransactionDTO transaction =
        await _createTransaction(methodName, methodArgs, 0.0, gasFees);

    // Serialize Transaction
    Uint8List serializedTransaction =
        TransactionManager.serializeTransaction(transaction);
    Uint8List hashedSerializedTx =
        TransactionManager.toSHA256(serializedTransaction);

    // Sign Transaction
    Uint8List signature = TransactionManager.signTransaction(
        nearConnectionConfig.keyPair.privateKey, hashedSerializedTx);

    // Serialize Signed Transaction
    Uint8List serializedSignedTransaction =
        TransactionManager.serializeSignedTransaction(transaction, signature);
    String encodedTransaction =
        TransactionManager.encodeSerialization(serializedSignedTransaction);

    // Broadcast Transaction
    return await NEARRpcApi.broadcastTransaction(
        encodedTransaction, nearConnectionConfig.rpcUrl);
  }

  Future<String> callWithDeposit(
      String methodName, String methodArgs, Wallet wallet, double nearAmount,
      [int gasFees = Constants.defaultGas]) async {
    TransactionDTO transaction =
        await _createTransaction(methodName, methodArgs, nearAmount, gasFees);

    // Serialize Transaction
    Uint8List serializedTransaction =
        TransactionManager.serializeTransaction(transaction);

    // Sign with wallet if there is a deposit
    String transactionEncoded =
        TransactionManager.encodeSerialization(serializedTransaction);
    wallet.requestDepositApproval(transactionEncoded);
    return "Please follow wallet to approve transaction";
  }

  Future<TransactionDTO> _createTransaction(
      methodName, methodArgs, nearAmount, gasFees) async {
    // Get Access Key Info
    AccessKey accessKey = await NEARRpcApi.getAccessKey(nearConnectionConfig);

    // Create Transaction
    accessKey.nonce++;
    String publicKey =
        KeyStore.publicKeyToString(nearConnectionConfig.keyPair.publicKey);
    return TransactionDTO(
        actionType: 'function_call',
        signer: nearConnectionConfig.signer,
        publicKey: publicKey,
        nearAmount: nearAmount.toStringAsFixed(12),
        gasFees: gasFees,
        receiver: contractId,
        methodName: methodName,
        methodArgs: methodArgs,
        accessKey: accessKey);
  }

  view(methodName, args) {
    //nearConnectionConfig.rpcUrl
    //nearConnectionConfig.keyPair
    //nearConnectionConfig.networkId
    //TODO Create Transaction Object

    //TODO SignTransaction
    //LocalTransactionAPI.serializeTransaction(transaction)
    //LocalTransactionAPI.signTransaction(transaction)
  }
}
