import 'dart:typed_data';
import 'package:near_api_flutter/near_api_flutter.dart';
import 'package:near_api_flutter/src/constants.dart';
import 'package:near_api_flutter/src/models/access_key.dart';
import 'package:near_api_flutter/src/models/transaction_dto.dart';
import 'package:near_api_flutter/src/transaction_api/near_rpc_api.dart';
import 'package:near_api_flutter/src/transaction_api/transaction_manager.dart';

class Account {
  String contractId;
  NEARConnectionConfig nearConnectionConfig;
  Account({required this.contractId, required this.nearConnectionConfig});

  Future<String> transferNear(double nearAmount, String receiver) async {
    TransactionDTO transaction = await _createTransaction(
        'transfer', '', '', nearAmount, Constants.defaultGas);

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

  Future<String> call(String methodName, String methodArgs,
      [double nearAmount = 0.0, int gasFees = Constants.defaultGas]) async {
    TransactionDTO transaction = await _createTransaction(
        'function_call', methodName, methodArgs, nearAmount, gasFees);

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

  Future<TransactionDTO> _createTransaction(
      actionType, methodName, methodArgs, nearAmount, gasFees) async {
    // Get Access Key Info
    AccessKey accessKey = await NEARRpcApi.getAccessKey(nearConnectionConfig);

    // Create Transaction
    accessKey.nonce++;
    String publicKey =
        KeyStore.publicKeyToString(nearConnectionConfig.keyPair.publicKey);
    return TransactionDTO(
        actionType: actionType,
        signer: nearConnectionConfig.signer,
        publicKey: publicKey,
        nearAmount: nearAmount.toStringAsFixed(12),
        gasFees: gasFees,
        receiver: contractId,
        methodName: methodName,
        methodArgs: methodArgs,
        accessKey: accessKey);
  }
}
