import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  String networkId = "testnet";
  String walletURL = 'https://wallet.testnet.near.org/login/?';
  String helperUrl = 'https://helper.testnet.near.org"';
  String explorerUrl = 'https://explorer.testnet.near.org';
  String rpcUrl = 'https://archival-rpc.testnet.near.org';
  String nearSignInSuccessUrl =
      'https://near-transaction-serializer.herokuapp.com/success';
  String nearSignInFailUrl =
      'https://near-transaction-serializer.herokuapp.com/failure';
  String method = 'submitMessage';
  String methodArgs = '{"content":"message text","receiver":"htahir.testnet"}';
  String contractId = 'friendbook.hamzatest.testnet';
  String contractTitle = 'Friendbook';
  String userId = 'hamzatest.testnet';
  double nearTransferAmount = 1;
  double nearDepositAmount = 1;

  late KeyPair limitedAccessKeyPair;
  late KeyPair fullAccessKeyPair;

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
            _buildInputCard(),
            _buildHorizontalSpace(),
            _buildLimitedAccessCard(),
            _buildHorizontalSpace(),
            _buildFullAccessCard(),
          ],
        ),
      ),
    );
  }

  _buildHorizontalSpace() {
    return const SizedBox(
      height: 2,
    );
  }

  _buildInputCard() {
    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Column(
            children: [
              _buildContractId(),
              _buildHorizontalSpace(),
              _buildMethodName(),
              _buildHorizontalSpace(),
              _buildUserId()
            ],
          )),
    );
  }

  _buildLimitedAccessCard() {
    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Column(
            children: [
              _buildLoginLimitedAccessButton(),
              _buildHorizontalSpace(),
              _buildLimitedAccessCallButtons(),
            ],
          )),
    );
  }

  _buildFullAccessCard() {
    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Column(
            children: [
              _buildLoginFullAccessButton(),
              _buildHorizontalSpace(),
              _buildTransferNearButton(),
              _buildHorizontalSpace(),
              _buildFullAccessCallButtons(),
            ],
          )),
    );
  }

  _buildLimitedAccessCallButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildLimitedAccessMethodCall(),
        _buildLimitedAccessMethodCallWithDeposit()
      ],
    );
  }

  _buildFullAccessCallButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildFullAccessMethodCall(),
        _buildFullAccessMethodCallWithDeposit()
      ],
    );
  }

  _buildContractId() {
    return Text(
      "Contract: $contractId",
    );
  }

  _buildMethodName() {
    return Text(
      "Mutate State Method: $method",
    );
  }

  _buildUserId() {
    return Text(
      "User: $userId",
    );
  }

  _buildLoginLimitedAccessButton() {
    return ElevatedButton(
      onPressed: () {
        _loginWithLimitedAccess();
      },
      child: const Text("Login Limited Access"),
    );
  }

  _buildLimitedAccessMethodCall() {
    return ElevatedButton(
      onPressed: () {
        assert(limitedAccessKeyPair.privateKey.bytes.isNotEmpty);
        assert(limitedAccessKeyPair.publicKey.bytes.isNotEmpty);
        _callMethodWithLimitedAccess();
      },
      child: const Text("Call without deposit"),
    );
  }

  _callMethodWithLimitedAccess() {
    NEARConnectionConfig nearConnectionConfig = NEARConnectionConfig(networkId,
        limitedAccessKeyPair, walletURL, helperUrl, explorerUrl, rpcUrl);

    Contract contract = Contract(contractId, nearConnectionConfig);
    contract.call(method, methodArgs);
  }

  _buildTransferNearButton() {
    return ElevatedButton(
      onPressed: () {},
      child: Text("Transfer ${nearTransferAmount.toString()} Near"),
    );
  }

  _buildFullAccessMethodCall() {
    return ElevatedButton(
      onPressed: () {},
      child: const Text("Call without deposit"),
    );
  }

  _buildLimitedAccessMethodCallWithDeposit() {
    return ElevatedButton(
      onPressed: () {},
      child: Text("Call with ${nearTransferAmount.toString()} Near deposit"),
    );
  }

  _buildFullAccessMethodCallWithDeposit() {
    return ElevatedButton(
      onPressed: () {},
      child: Text("Call with ${nearDepositAmount.toString()} Near deposit"),
    );
  }

  _buildLoginFullAccessButton() {
    return ElevatedButton(
      onPressed: () {},
      child: const Text("Login Full Access"),
    );
  }

  _loginWithLimitedAccess() {
    //generate keys
    limitedAccessKeyPair = KeyStore.newKeyPair();
    if (kDebugMode) {
      print(KeyStore.publicKeyToString(limitedAccessKeyPair.publicKey));
    }

    assert(limitedAccessKeyPair.privateKey.bytes.isNotEmpty);
    assert(limitedAccessKeyPair.publicKey.bytes.isNotEmpty);

    //wallet login
    WalletConnectionConfig walletConnectionParam = WalletConnectionConfig(
        contract: contractId,
        appTitle: contractTitle,
        successURL: nearSignInSuccessUrl,
        failureURL: nearSignInFailUrl);

    Wallet wallet =
        Wallet(walletURL, limitedAccessKeyPair, walletConnectionParam);
    wallet.requestSignIn();
  }
}
