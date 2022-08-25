
class WalletConnectionConfig {
  String successURL;
  String contract;
  String appTitle;
  String failureURL;


  WalletConnectionConfig(
      {required this.contract, required this.appTitle, required this.successURL, required this.failureURL});
}