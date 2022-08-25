import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/transaction_dto.dart';

class NEARRpcApi {
  //call near RPC API's  getAccessKeys for nonce and block hash
  static Future<Map<String, dynamic>> getAccessKey(
      TransactionDTO transaction, nearRPCUrl) async {

    var body = json.encode({
      "jsonrpc": "2.0",
      "id": "dontcare",
      "method": "query",
      "params": {
        "request_type": "view_access_key",
        "finality": "final",
        "account_id": transaction.sender,
        "public_key": "ed25519:${transaction.publicKey}"
      }
    });
    Map<String, String> headers = {};
    headers[Constants.contentType] = Constants.applicationJson;

    http.Response responseData =
        await http.post(Uri.parse(nearRPCUrl), headers: headers, body: body);

    dynamic jsonBody = jsonDecode(responseData.body);
    return jsonBody['result'];
  }
  //broadcastTransaction
  static Future<bool> broadcastTransaction(TransactionDTO transaction,nearRPCUrl) async {

    var body = json.encode({
      "jsonrpc": "2.0",
      "id": "dontcare",
      "method": "broadcast_tx_commit",
      "params": [transaction.encoded]
    });
    Map<String, String> headers = {};
    headers[Constants.contentType] = Constants.applicationJson;

    http.Response responseData =
        await http.post(Uri.parse(nearRPCUrl), headers: headers, body: body);

    Map jsonBody = jsonDecode(responseData.body);
    return jsonBody.containsKey('result');
  }
}
