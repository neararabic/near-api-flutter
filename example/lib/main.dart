import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:near_api_flutter/near_api_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'NEAR Flutter API Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: const Text("near-flutter-api"),
            ),
            body: const MyHomePage()));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
              ),
              ElevatedButton(
                //call method
                onPressed: () async {
                  String contractId = 'friendbook.hamzatest.testnet';
                  String method = 'getAllMessages';
                  String methodArgs = '';

                  Contract contract = Contract(contractId, connectedAccount);
                  response = await NEARTester.callViewMethod(
                      contract, method, methodArgs);
                  setState(() {});
                },
                child: const Text("Call view function"),
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
            "Function Response",
            (utf8.decode(base64.decoder
                .convert(response['result']['status']['SuccessValue'])))),
      ));
    } else if (response.isNotEmpty &&
        response.containsKey('result') &&
        response['result'].containsKey('result')) {
      String resultDecoded =
          utf8.decode(response['result']['result'].cast<int>());
      return Card(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: buildCopyableText("Function Response", resultDecoded)));
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
              ),
              ElevatedButton(
                //call method
                onPressed: () async {
                  String contractId = 'friendbook.hamzatest.testnet';
                  String method = 'getAllMessages';
                  String methodArgs = '';

                  Contract contract = Contract(contractId, connectedAccount);
                  response = await NEARTester.callViewMethod(
                      contract, method, methodArgs);
                  setState(() {});
                },
                child: const Text("Call view function"),
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

class NEARTester {
  static loginWithLimitedAccess(walletURL, contractId, accountId, appTitle,
      signInSuccessUrl, signInFailureUrl) {
    // Generate Keys
    var keyPair = KeyStore.newKeyPair();

    // Open near wallet in default browser
    Account account = Account(
        accountId: accountId,
        keyPair: keyPair,
        provider: NEARTestNetRPCProvider());

    var wallet = Wallet(walletURL);
    wallet.connect(contractId, appTitle, signInSuccessUrl, signInFailureUrl,
        account.publicKey);

    return account; //connected account
  }

  static loginWithFullAccess(walletURL, contractId, accountId, appTitle,
      signInSuccessUrl, signInFailureUrl) {
    // Generate Keys
    var keyPair = KeyStore.newKeyPair();
    var publicKey = KeyStore.publicKeyToString(keyPair.publicKey);

    // Open near wallet in default browser
    var wallet = Wallet(walletURL);

    wallet.connectWithFullAccess(
        contractId, appTitle, signInSuccessUrl, signInFailureUrl, publicKey);

    Account account = Account(
        accountId: accountId,
        keyPair: keyPair,
        provider: NEARTestNetRPCProvider());

    return account; //connected account
  }

  //contract holds the account to use for calling
  static callMethodLimitedAccess(Contract contract, String method, args) async {
    var result = await contract.callFunction(method, args);
    return result;
  }

  static callViewMethod(Contract contract, String method, args) async {
    var result = await contract.callViewFuntion(method, args);
    return result;
  }

  //contract holds the account to use for calling - account must have a full access key
  static callMethodFullAccess(Contract contract, String method, args) async {
    var result = await contract.callFunction(method, args);
    return result;
  }

  static callMethodFullAccessWithDeposit(
      Contract contract, String method, args, nearAmount) async {
    var result = await contract.callFunction(method, args, nearAmount);
    return result;
  }

  static callMethodLimitedAccessWithDeposit(
      Contract contract,
      String method,
      String walletURL,
      args,
      nearAmount,
      successUrl,
      failureUrl,
      approvalURL) async {
    // Open near wallet in default browser
    var wallet = Wallet(walletURL);

    var result = await contract.callFunctionWithDeposit(
        method, args, wallet, nearAmount, successUrl, failureUrl, approvalURL);
    return result;
  }

  static transferNear(Account account, nearAmount, receiver) async {
    var result = await account.sendTokens(nearAmount, receiver);
    return result;
  }
}
