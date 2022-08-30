import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:near_api_flutter/src/models/access_key.dart';
import '../constants.dart';

class NEARTestNetRPCProvider extends RPCProvider{

  static final NEARTestNetRPCProvider _nearTestNetRPCProvider = NEARTestNetRPCProvider._internal();

  factory NEARTestNetRPCProvider() {
    return _nearTestNetRPCProvider;
  }

  NEARTestNetRPCProvider._internal():super('https://archival-rpc.testnet.near.org');
}

abstract class RPCProvider {
  String providerURL;

  RPCProvider(this.providerURL);

  //call near RPC API's getAccessKeys for nonce and block hash
  Future<AccessKey> getAccessKey(
      accountId, publicKey) async {
    var body = json.encode({
      "jsonrpc": "2.0",
      "id": "dontcare",
      "method": "query",
      "params": {
        "request_type": "view_access_key",
        "finality": "final",
        "account_id": accountId,
        "public_key":
            "ed25519:$publicKey"
      }
    });
    Map<String, String> headers = {};
    headers[Constants.contentType] = Constants.applicationJson;

    http.Response responseData = await http.post(
        Uri.parse(providerURL),
        headers: headers,
        body: body);

    dynamic jsonBody = jsonDecode(responseData.body);
    return AccessKey.fromJson(jsonBody['result']);
  }

  //broadcastTransaction
   Future<String> broadcastTransaction(
      String encodedTransaction) async {
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
          await http.post(Uri.parse(providerURL), headers: headers, body: body);
      Map jsonBody = jsonDecode(responseData.body);
      return json.encode(jsonBody['result']);
    } catch (exp) {
      return "EXCEPTION: $exp";
    }
  }
}
