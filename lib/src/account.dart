import 'package:near_api_flutter/src/transaction_api/transaction_manager.dart';

class Account{
  String accountId;
  Account(this.accountId);

  void sendTokens(double tokens, String s) {
    //TODO Create Transaction
    //TransactionManager.sendTransaction
    //TransactionManager.signTransaction(privateKey, hashedSerializedTx)
  }
}