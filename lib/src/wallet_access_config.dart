
class WalletConnectionParams {
  String successURL;
  String contract;
  String appTitle;
  String failureURL;


  WalletConnectionParams(
      {required this.contract, required this.appTitle, required this.successURL, required this.failureURL});
}