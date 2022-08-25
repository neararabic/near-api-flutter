import 'dart:typed_data';
import 'package:bs58/bs58.dart';
import 'package:ed25519_edwards/ed25519_edwards.dart' as ed;
class KeyPair extends ed.KeyPair{
   ed.PrivateKey privateKey;
   ed.PublicKey publicKey;

  KeyPair(this.privateKey, this.publicKey):super(privateKey, publicKey);

}
class KeyStore {

  static KeyPair newKeyPair(){
    ed.KeyPair keypair =  ed.generateKey();
    return  KeyPair(keypair.privateKey,keypair.publicKey);
  }

  static String publicKeyToString(ed.PublicKey keyPair) {
      return base58.encode(Uint8List.fromList(keyPair.bytes));

  }
}