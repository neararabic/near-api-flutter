import 'dart:convert';
import 'dart:typed_data';
import 'package:bs58/bs58.dart';
import 'package:crypto/crypto.dart';
import 'package:ed25519_edwards/ed25519_edwards.dart' as ed;
import 'package:near_api_flutter/src/models/keys/public_key.dart';
import '../models/actions/action_function_call.dart';
import '../models/actions/action_transfer.dart';
import '../models/transaction_dto.dart';
import '../models/signature/signature.dart';
import '../models/signed_transactions/signed_transaction_function_call.dart';
import '../models/signed_transactions/signed_transaction_transfer.dart';
import '../models/transactions/transaction_function_call.dart';
import '../models/transactions/transaction_transfer.dart';
import '../utils.dart';

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
                  deposit: Utils.decodeNearDeposit(transaction.nearAmount)))
        ],
        blockHash: base58.decode(transaction.accessKey.blockHash),
        nonce: BigInt.from(transaction.accessKey.nonce),
        publicKey:
            PublicKey(data: base58.decode(transaction.publicKey), keyType: 0),
        receiverId: transaction.receiver,
        signerId: transaction.signer);
  }

  static FunctionCallTransaction _createFunctionCallTransaction(
      TransactionDTO transaction) {
    return FunctionCallTransaction(
        functionCallActions: [
          FunctionCallAction(
              actionNumber: 2,
              functionCallActionArgs: FunctionCallActionArgs(
                  methodName: transaction.methodName,
                  args: transaction.methodArgs,
                  gas: BigInt.from(transaction.gasFees),
                  deposit: Utils.decodeNearDeposit(transaction.nearAmount)))
        ],
        blockHash: base58.decode(transaction.accessKey.blockHash),
        nonce: BigInt.from(transaction.accessKey.nonce),
        publicKey:
            PublicKey(data: base58.decode(transaction.publicKey), keyType: 0),
        receiverId: transaction.receiver,
        signerId: transaction.signer);
  }

  static Uint8List toSHA256(Uint8List serializedTransaction) {
    return Uint8List.fromList(sha256.convert(serializedTransaction).bytes);
  }

  static Uint8List serializeSignedTransaction(
      TransactionDTO transaction, Uint8List signature) {
    if (transaction.actionType == 'transfer') {
      TransferTransaction transferTransaction =
          _createTransferTransaction(transaction);
      SignedTransferTransaction signedTransferTransaction =
          _createSignedTransferTransaction(transferTransaction, signature);
      return signedTransferTransaction.toBorsh();
    } else if (transaction.actionType == 'function_call') {
      FunctionCallTransaction functionCallTransaction =
          _createFunctionCallTransaction(transaction);
      SignedFunctionCallTransaction signedFunctionCallTransaction =
          _createSignedFunctionCallTransaction(
              functionCallTransaction, signature);
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
}
