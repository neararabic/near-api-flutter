import 'dart:convert';
import 'dart:typed_data';
import 'package:bs58/bs58.dart';
import 'package:crypto/crypto.dart';
import 'package:ed25519_edwards/ed25519_edwards.dart' as ed;
import 'package:near_api_flutter/src/connection_config.dart';
import 'package:near_api_flutter/src/models/keys/public_key.dart';
import '../constants.dart';
import '../models/actions/action_function_call.dart';
import '../models/actions/action_transfer.dart';
import '../models/transaction_dto.dart';
import '../models/signature/signature.dart';
import '../models/signed_transactions/signed_transaction_function_call.dart';
import '../models/signed_transactions/signed_transaction_transfer.dart';
import '../models/transactions/transaction_function_call.dart';
import '../models/transactions/transaction_transfer.dart';
import '../utils.dart';
import 'near_rpc_api.dart';

/// The dart method for key generation and transaction signing
class TransactionManager {
  //signTransaction by user's private key using ed library
  static Uint8List signTransaction(
      ed.PrivateKey privateKey, Uint8List hashedSerializedTx) {
    Uint8List signature = ed.sign(privateKey, hashedSerializedTx);
    return signature;
  }

  static Uint8List serializeTransaction(TransactionDTO transaction) {
    if (transaction.actionType == 'transfer') {
      TransferTransaction transferTransaction =
          _createTransferTransaction(transaction);
      return transferTransaction.toBorsh();
    } else if (transaction.actionType == 'function_call') {
      FunctionCallTransaction functionCallTransaction =
          _createFunctionCallTransaction(transaction);
      return functionCallTransaction.toBorsh();
    } else {
      return Uint8List(0);
    }
  }

  static TransferTransaction _createTransferTransaction(
      TransactionDTO transaction) {
    return TransferTransaction(
        transferActions: [
          TransferAction(
              actionNumber: 3,
              transferActionArgs: TransferActionArgs(
                  deposit:
                      Utils.decodeNearDeposit(transaction.amount as String)))
        ],
        blockHash: base58.decode(transaction.blockHash as String),
        nonce: BigInt.from(transaction.nonce as int),
        publicKey: PublicKey(
            data: base58.decode(transaction.publicKey as String), keyType: 0),
        receiverId: transaction.receiver as String,
        signerId: transaction.sender as String);
  }

  static FunctionCallTransaction _createFunctionCallTransaction(
      TransactionDTO transaction) {
    return FunctionCallTransaction(
        functionCallActions: [
          FunctionCallAction(
              actionNumber: 2,
              functionCallActionArgs: FunctionCallActionArgs(
                  methodName: transaction.methodName as String,
                  args: transaction.methodArgsString as String,
                  gas: BigInt.from(Constants.defaultGas),
                  deposit: Utils.decodeNearDeposit("0")))
        ],
        blockHash: base58.decode(transaction.blockHash as String),
        nonce: BigInt.from(transaction.nonce as int),
        publicKey: PublicKey(
            data: base58.decode(transaction.publicKey as String), keyType: 0),
        receiverId: transaction.receiver as String,
        signerId: transaction.sender as String);
  }

  static Uint8List toSHA256(Uint8List serializedTransaction) {
    return Uint8List.fromList(sha256.convert(serializedTransaction).bytes);
  }

  static Uint8List serializeSignedTransaction(TransactionDTO transaction) {
    if (transaction.actionType == 'transfer') {
      TransferTransaction transferTransaction =
          _createTransferTransaction(transaction);
      SignedTransferTransaction signedTransferTransaction =
          _createSignedTransferTransaction(
              transferTransaction, transaction.signature as Uint8List);
      return signedTransferTransaction.toBorsh();
    } else if (transaction.actionType == 'function_call') {
      FunctionCallTransaction functionCallTransaction =
          _createFunctionCallTransaction(transaction);
      SignedFunctionCallTransaction signedFunctionCallTransaction =
          _createSignedFunctionCallTransaction(
              functionCallTransaction, transaction.signature as Uint8List);
      return signedFunctionCallTransaction.toBorsh();
    } else {
      return Uint8List(0);
    }
  }

  static SignedTransferTransaction _createSignedTransferTransaction(
      TransferTransaction transferTransaction, Uint8List signature) {
    return SignedTransferTransaction(
        transferTransaction: transferTransaction,
        signature: Signature(keyType: 0, data: signature));
  }

  static SignedFunctionCallTransaction _createSignedFunctionCallTransaction(
      FunctionCallTransaction functionCallTransaction, Uint8List signature) {
    return SignedFunctionCallTransaction(
        functionCallTransaction: functionCallTransaction,
        signature: Signature(keyType: 0, data: signature));
  }

  static encodeSerialization(Uint8List serialization) {
    return base64Encode(serialization);
  }

  sendTransaction( TransactionDTO transaction, NEARConnectionConfig connectionConfig) async {
    transaction.networkId = connectionConfig.networkId;
    var accessKey = await NEARRpcApi.getAccessKey(transaction, connectionConfig.rpcUrl);
    transaction.nonce = ++accessKey['nonce'];
    transaction.blockHash = accessKey['block_hash'];

    Uint8List serializedTransaction =
    TransactionManager.serializeTransaction(transaction);
    Uint8List hashedSerializedTx =
    TransactionManager.toSHA256(serializedTransaction);

    transaction.signature = TransactionManager.signTransaction(
        connectionConfig.keyPair.privateKey, hashedSerializedTx);

    Uint8List signedTransactionSerialization =
    TransactionManager.serializeSignedTransaction(transaction);
    transaction.encoded =
        TransactionManager.encodeSerialization(signedTransactionSerialization);

      if (transaction.encoded!.isNotEmpty) {
        bool transactionSucceeded =
        await NEARRpcApi.broadcastTransaction(transaction, connectionConfig.rpcUrl);
        transactionSucceeded
            ? transaction.returnMessage = Constants.transactionSuccessMessage
            : transaction.returnMessage = Constants.transactionFailedMessage;
      }

  }
}
