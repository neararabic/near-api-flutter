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

  TransactionDTO({required this.actionType,
      required this.signer,
      required this.publicKey,
      required this.nearAmount,
      required this.gasFees,
      required this.receiver,
      required this.methodName,
      required this.methodArgs,
      required this.accessKey}
      );
}
