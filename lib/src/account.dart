import 'dart:typed_data';
import 'package:near_api_flutter/near_api_flutter.dart';
import 'package:near_api_flutter/src/constants.dart';
import 'package:near_api_flutter/src/models/access_key.dart';
import 'package:near_api_flutter/src/models/action_types.dart';
import 'package:near_api_flutter/src/models/transaction_dto.dart';
import 'package:near_api_flutter/src/transaction_api/transaction_manager.dart';

///This class provides common account related RPC calls
///including signing transactions with a KeyPair.
class Account {
  String accountId;
  KeyPair keyPair;

  String get publicKey =>  KeyStore.publicKeyToString(keyPair.publicKey);
  RPCProvider
      provider; //need for the account to call methods and create transactions
  Account(
      {required this.accountId, required this.keyPair, required this.provider});

  Future<String> sendTokens(double nearAmount, String receiver) async {
    AccessKey accessKey = await getAccessKey();

    // Create Transaction
    accessKey.nonce++;
    String publicKey = KeyStore.publicKeyToString(keyPair.publicKey);

    Transaction transaction = Transaction(
        signer: accountId,
        publicKey: publicKey,
        nearAmount: nearAmount.toStringAsFixed(12),
        gasFees: Constants.defaultGas,
        receiver: receiver,
        methodName: '',
        methodArgs: '',
        accessKey: accessKey,
        actionType: ActionType.transfer);

    // Serialize Transaction
    Uint8List serializedTransaction =
        TransactionManager.serializeTransferTransaction(transaction);
    Uint8List hashedSerializedTx =
        TransactionManager.toSHA256(serializedTransaction);

    // Sign Transaction
    Uint8List signature = TransactionManager.signTransaction(
        keyPair.privateKey, hashedSerializedTx);

    // Serialize Signed Transaction
    Uint8List serializedSignedTransaction =
        TransactionManager.serializeSignedTransferTransaction(transaction, signature);
    String encodedTransaction =
        TransactionManager.encodeSerialization(serializedSignedTransaction);

    // Broadcast Transaction
    return await provider.broadcastTransaction(encodedTransaction);
  }

  Future<AccessKey> getAccessKey() async {
    return await provider.getAccessKey(
        accountId, KeyStore.publicKeyToString(keyPair.publicKey));
  }
}
