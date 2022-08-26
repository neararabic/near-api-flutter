class WalletConnectionConfig {
  String contract;
  String appTitle;
  String loginSuccessURL;
  String loginFailureURL;
  String transactionSuccessURL;

  WalletConnectionConfig(
      {required this.contract,
      required this.appTitle,
      required this.loginSuccessURL,
      required this.loginFailureURL,
      required this.transactionSuccessURL});
}
