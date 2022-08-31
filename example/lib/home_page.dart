import 'dart:convert';

import 'package:example/near_logic.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:near_api_flutter/near_api_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String walletApproveTransactionUrl = 'https://wallet.testnet.near.org/sign?';
  // String helperUrl = 'https://helper.testnet.near.org"';
  // String explorerUrl = 'https://explorer.testnet.near.org';
  // String rpcUrl = 'https://archival-rpc.testnet.near.org';
  // String nearSignInSuccessUrl =
  //     'https://near-transaction-serializer.herokuapp.com/success';
  // String nearSignInFailUrl =
  //     'https://near-transaction-serializer.herokuapp.com/failure';
  // String methodArgs = '{"content":"message text","receiver":"htahir.testnet"}';
  // String contractTitle = 'Friendbook';
  // String signerId = 'mhassanist.testnet';
  // double nearTransferAmount = 1;
  // double nearAmount = 1;
  //
  // late KeyPair limitedAccessKeyPair;
  // late KeyPair fullAccessKeyPair;
  //
  // late WalletConnectionArgs walletConnectionParam;
  //
  // bool isLoading = false;

  Map response = {};
  String contractId = 'friendbook.hamzatest.testnet';
  String method = 'submitMessage';
  String signerId = 'hamzatest.testnet';

  late Account connectedAccount;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Contract: $contractId",
            ),
            Text(
              "Mutate State Method: $method",
            ),
            Text(
              "User: $signerId",
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildLimitedAccessCard(),
                buildFullAccessCard(),
                buildFunctionResponseCard(),
                buildTransactionResponseCard(),
              ],
            )
          ],
        ),
      ),
    );
  }

  ///Limited Access
  buildLimitedAccessCard() {
    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Column(
            children: [
              ElevatedButton(
                //connect
                onPressed: () {
                  String walletURL = 'https://wallet.testnet.near.org/login/?';
                  String contractId = 'friendbook.hamzatest.testnet';
                  String appTitle = 'Friendbook';
                  String accountId = 'hamzatest.testnet';
                  String nearSignInSuccessUrl =
                      'https://near-transaction-serializer.herokuapp.com/success';
                  String nearSignInFailUrl =
                      'https://near-transaction-serializer.herokuapp.com/failure';

                  connectedAccount = NEARTester.loginWithLimitedAccess(
                      walletURL,
                      contractId,
                      accountId,
                      appTitle,
                      nearSignInSuccessUrl,
                      nearSignInFailUrl);
                },
                child: const Text("Login Limited Access"),
              ),
              ElevatedButton(
                //call method
                onPressed: () async {
                  String method = 'submitMessage';
                  String methodArgs =
                      '{"content":"message text","receiver":"htahir.testnet"}';
                  String contractId = 'friendbook.hamzatest.testnet';

                  Contract contract = Contract(contractId, connectedAccount);
                  response = await NEARTester.callMethodLimitedAccess(
                      contract, method, methodArgs);
                  setState(() {});
                },
                child: const Text("Call without deposit"),
              ),
              ElevatedButton(
                //call with deposit
                onPressed: () async {
                  setState(() {
                    response = {};
                  });

                  String method = 'submitMessage';
                  String methodArgs =
                      '{"content":"message text","receiver":"htahir.testnet"}';
                  String contractId = 'friendbook.hamzatest.testnet';
                  String nearSignInSuccessUrl =
                      'https://near-transaction-serializer.herokuapp.com/success';
                  String nearSignInFailUrl =
                      'https://near-transaction-serializer.herokuapp.com/failure';

                  Contract contract = Contract(contractId, connectedAccount);
                  String walletURL = 'https://wallet.testnet.near.org/login/?';
                  String walletApproveTransactionUrl =
                      'https://wallet.testnet.near.org/sign?';

                  response =
                      await NEARTester.callMethodLimitedAccessWithDeposit(
                          contract,
                          method,
                          walletURL,
                          methodArgs,
                          1.0,
                          nearSignInSuccessUrl,
                          nearSignInFailUrl,
                          walletApproveTransactionUrl);
                  setState(() {});
                },
                child: Text("Call with ${"1".toString()} Near deposit"),
              )
            ],
          )),
    );
  }

  buildTransactionResponseCard() {
    if (response.isNotEmpty) {
      return Card(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: buildCopyableText("Transaction Response", json.encode(response)),
      ));
    } else {
      return Container();
    }
  }

  buildFunctionResponseCard() {
    if (response.isNotEmpty &&
        response.containsKey('result') &&
        response['result'].containsKey('status') &&
        response['result']['status'].containsKey('SuccessValue') &&
        response['result']['status']['SuccessValue'] != '') {
      return Card(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: buildCopyableText(
            "Function Respones",
            (utf8.decode(base64.decoder
                .convert(response['result']['status']['SuccessValue'])))),
      ));
    } else {
      return Container();
    }
  }

  buildFullAccessCard() {
    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  //Generate Keys
                  KeyPair fullAccessKeyPair = KeyStore.newKeyPair();
                  if (kDebugMode) {
                    print(KeyStore.publicKeyToString(
                        fullAccessKeyPair.publicKey));
                  }

                  String walletURL = 'https://wallet.testnet.near.org/login/?';
                  String contractId = 'friendbook.hamzatest.testnet';
                  String appTitle = 'Friendbook';
                  String accountId = 'hamzatest.testnet';
                  String nearSignInSuccessUrl =
                      'https://near-transaction-serializer.herokuapp.com/success';
                  String nearSignInFailUrl =
                      'https://near-transaction-serializer.herokuapp.com/failure';

                  connectedAccount = NEARTester.loginWithFullAccess(
                      walletURL,
                      contractId,
                      accountId,
                      appTitle,
                      nearSignInSuccessUrl,
                      nearSignInFailUrl);
                },
                child: const Text("Login Full Access"),
              ),
              ElevatedButton(
                onPressed: () async {
                  response = await NEARTester.transferNear(
                      connectedAccount, 1.0, "hamzatest.testnet");
                  setState(() {});
                },
                child: Text("Transfer ${"1".toString()} Near"),
              ),
              ElevatedButton(
                onPressed: () async {
                  String method = 'submitMessage';
                  String methodArgs =
                      '{"content":"message text","receiver":"htahir.testnet"}';
                  String contractId = 'friendbook.hamzatest.testnet';
                  Contract contract = Contract(contractId, connectedAccount);

                  response = await NEARTester.callMethodFullAccess(
                      contract, method, methodArgs);
                  setState(() {});
                },
                child: const Text("Call without deposit"),
              ),
              ElevatedButton(
                onPressed: () async {
                  String method = 'submitMessage';
                  String methodArgs =
                      '{"content":"message text","receiver":"htahir.testnet"}';
                  String contractId = 'friendbook.hamzatest.testnet';

                  Contract contract = Contract(contractId, connectedAccount);

                  response = await NEARTester.callMethodFullAccessWithDeposit(
                      contract, method, methodArgs, 1.0);
                  setState(() {});
                },
                child: Text("Call with ${"1".toString()} Near deposit"),
              )
            ],
          )),
    );
  }

  buildCopyableText(String title, String longString) {
    if (longString.isNotEmpty) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${title.toUpperCase()}:"),
              InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: longString));
                  },
                  child: const Icon(Icons.copy))
            ],
          ),
          Row(children: [Flexible(child: Text(longString))]),
        ],
      );
    } else {
      return Container();
    }
  }
}
