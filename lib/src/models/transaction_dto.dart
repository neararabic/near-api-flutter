import 'package:near_api_flutter/src/models/access_key.dart';

class TransactionDTO {
  String actionType;
  String signer;
  String publicKey;
  String nearAmount;
  int gasFees;
  String receiver;
  String methodName;
  String methodArgs;
  AccessKey accessKey;

  TransactionDTO(
      this.actionType,
      this.signer,
      this.publicKey,
      this.nearAmount,
      this.gasFees,
      this.receiver,
      this.methodName,
      this.methodArgs,
      this.accessKey);
}
