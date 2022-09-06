# NEAR FLutter API

NEAR Flutter API is here to help mobile developers to build flutter apps that connect and send transactions to the NEAR PROTOCOL Blockchain

# Currently Implemented Features
- Genererate Keys
- Connect Wallet With Limited or Full Access Keys
- Send NEAR Tokens
- Call smart-contract methods

# In-progerss Features
- Create Account

# Sample Usage

## Generate Keys
```
var keyPair = KeyStore.newKeyPair();
```

## Connect Wallet
```
Account account = Account(accountId: accountId, keyPair: keyPair, provider: NEARTestNetRPCProvider());
var wallet = Wallet(walletURL);
wallet.connect(contractId, appTitle, signInSuccessUrl, signInFailureUrl , account.publicKey);
```

## Send Tokens (Full Access Key)
```
await account.sendTokens(nearAmount, receiver);
```

## Call Smart Contract Methods (without deposit)
```
Contract contract = Contract(contractId, account);
var result = await contract.callFunction(method, args);
```

## Call Smart Contract Methods (without deposit) 
```
var result = await contract.callFunctionWithDeposit(method, args, wallet, nearAmount, successUrl, failureUrl, approvalURL);
```

## Call Smart Contract Methods (without deposit) (Full Access Key)
Calls with a full access key will not invoke wallets.
```
var result = await contract.callFunction(method, args, nearAmount);
```


