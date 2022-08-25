
import 'package:near_api_flutter/src/connection_config.dart';
import 'package:near_api_flutter/src/transaction_api/transaction_manager.dart';

class Contract{
  String contractId;
  NEARConnectionConfig nearConnectionConfig;
  Contract(this.contractId, this.nearConnectionConfig);

  call(methodName, args){
    //nearConnectionConfig.rpcUrl
    //nearConnectionConfig.keyPair
    //nearConnectionConfig.networkId
    //TODO Create Transaction Object

    //TODO SignTransaction
    //LocalTransactionAPI.serializeTransaction(transaction)
    //LocalTransactionAPI.signTransaction(transaction)
  }
  view(methodName, args){
    //nearConnectionConfig.rpcUrl
    //nearConnectionConfig.keyPair
    //nearConnectionConfig.networkId
    //TODO Create Transaction Object

    //TODO SignTransaction
    //LocalTransactionAPI.serializeTransaction(transaction)
    //LocalTransactionAPI.signTransaction(transaction)
  }
}