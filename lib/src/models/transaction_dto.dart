import 'package:near_api_flutter/src/models/access_key.dart';
import 'package:near_api_flutter/src/models/action_types.dart';

class Transaction {
  ActionType actionType;
  String signer;
  String publicKey;
  String nearAmount;
  int gasFees;
  String receiver;
  String methodName;
  String methodArgs;
  AccessKey accessKey;

   Transaction(
      {required this.actionType,
      required this.signer,
      required this.publicKey,
      required this.nearAmount,
      required this.gasFees,
      required this.receiver,
      required this.methodName,
      required this.methodArgs,
      required this.accessKey});


}
