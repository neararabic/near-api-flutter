import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:near_api_flutter/near_api_flutter.dart';
import 'package:near_api_flutter/src/models/access_key.dart';
import '../constants.dart';

class NEARRpcApi {
  //call near RPC API's getAccessKeys for nonce and block hash
  static Future<AccessKey> getAccessKey(
      NEARConnectionConfig nearConnectionConfig) async {
    var body = json.encode({
      "jsonrpc": "2.0",
      "id": "dontcare",
      "method": "query",
      "params": {
        "request_type": "view_access_key",
        "finality": "final",
        "account_id": nearConnectionConfig.signer,
        "public_key":
            "ed25519:${KeyStore.publicKeyToString(nearConnectionConfig.keyPair.publicKey)}"
      }
    });
    Map<String, String> headers = {};
    headers[Constants.contentType] = Constants.applicationJson;

    http.Response responseData = await http.post(
        Uri.parse(nearConnectionConfig.rpcUrl),
        headers: headers,
        body: body);

    dynamic jsonBody = jsonDecode(responseData.body);
    return AccessKey.fromJson(jsonBody['result']);
  }

  //broadcastTransaction
  static Future<String> broadcastTransaction(
      String encodedTransaction, nearRPCUrl) async {
    var body = json.encode({
      "jsonrpc": "2.0",
      "id": "dontcare",
      "method": "broadcast_tx_commit",
      "params": [encodedTransaction]
    });
    Map<String, String> headers = {};
    headers[Constants.contentType] = Constants.applicationJson;

    try {
      http.Response responseData =
          await http.post(Uri.parse(nearRPCUrl), headers: headers, body: body);
      Map jsonBody = jsonDecode(responseData.body);
      return json.encode(jsonBody['result']);
    } catch (exp) {
      return "EXCEPTION: $exp";
    }
  }
}
