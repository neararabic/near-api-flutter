import 'package:borsh_annotation/borsh_annotation.dart';

class TransactionDTO {
  String? actionType;
  String? sender;
  String? publicKey;
  String? amount;
  String? receiver;
  String? networkId;
  String? blockHash;
  int? nonce;
  Uint8List? signature;
  String? encoded;
  String? returnMessage;
  String? methodName;
  String? methodArgsString = '{}';
  Map<String, dynamic>? methodArgs;

  Map<String, dynamic> toJson() => {
        "action_type": actionType,
        "sender": sender,
        "public_key": publicKey,
        "amount": amount,
        "receiver": receiver,
        "network_id": networkId,
        'block_hash': blockHash,
        'nonce': nonce,
        'method_name': methodName,
        'method_args': methodArgs,
        "signature": signature
      };
}
