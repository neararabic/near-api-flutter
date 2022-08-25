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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void requestSignIn() {
    // network and wallet config data
    const String networkId = "testnet";
    const String walletURL = 'https://wallet.testnet.near.org/login/?';
    const String helperUrl = 'https://helper.testnet.near.org"';
    const String explorerUrl = 'https://explorer.testnet.near.org';
    const String rpcUrl = 'https://archival-rpc.testnet.near.org';
    const String globalServer =
        'https://near-transaction-serializer.herokuapp.com';
    const String nearSignInSuccessUrl = '$globalServer/success';
    const String nearSignInFailUrl = '$globalServer/failure';

    //generate keys
    KeyPair keyPair = KeyStore.newKeyPair();
    if (kDebugMode) {
      print(KeyStore.publicKeyToString(keyPair.publicKey));
    }

    assert(keyPair.privateKey.bytes.isNotEmpty);
    assert(keyPair.publicKey.bytes.isNotEmpty);

    //wallet login
    WalletConnectionConfig walletConnectionParam = WalletConnectionConfig(
        contract: "friendbook.msaudi.testnet",
        appTitle: "FriendBook",
        successURL: nearSignInSuccessUrl,
        failureURL: nearSignInFailUrl);

    Wallet wallet = Wallet(walletURL, keyPair, walletConnectionParam);
    wallet.requestSignIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: requestSignIn,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


