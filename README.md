# NEAR FLutter API

NEAR Flutter API is an in-progress work to implement a library to interact with the NEAR blockchain. You can use it to build flutter apps that connect and send transactions to the NEAR Blockchain

# Currently Implemented Features
- Genererate Keys
- Connect Wallet With Limited and Full Access Keys
- Send Transactions


# Sample Usage

## Generate Keys
```
var keyPair = KeyStore.newKeyPair();
```

## Open near wallet in default browser
```
Account account = Account(accountId: accountId, keyPair: keyPair, provider: NEARTestNetRPCProvider());
var wallet = Wallet(walletURL);
wallet.connect(contractId, appTitle, signInSuccessUrl, signInFailureUrl , account.publicKey);
```

## Send Tokens with (Full Access Key)
```
await account.sendTokens(nearAmount, receiver);
```

## Call smart-contract methods without deposit
```
Contract contract = Contract(contractId, account);
var result = await contract.callFunction(method, args);
```

## Call smart-contract methods with deposit (Full Access Key)
```
var result = await contract.callFunction(method, args, nearAmount);
```

## Call smart-contract methods with deposit (Limited Access Key)
```
var result = await contract.callFunctionWithDeposit(method, args, wallet, nearAmount, successUrl, failureUrl, approvalURL);
```
