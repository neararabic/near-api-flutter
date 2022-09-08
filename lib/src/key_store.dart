import 'dart:typed_data';
import 'package:bs58/bs58.dart';
import 'package:ed25519_edwards/ed25519_edwards.dart' as ed;

class PrivateKey extends ed.PrivateKey {
  PrivateKey(super.bytes);
}

class PublicKey extends ed.PublicKey {
  PublicKey(super.bytes);
}

class KeyPair extends ed.KeyPair {
  PrivateKey privateKey;
  PublicKey publicKey;

  KeyPair(this.privateKey, this.publicKey) : super(privateKey, publicKey);
}

class KeyStore {
  static KeyPair newKeyPair() {
    ed.KeyPair keypair = ed.generateKey();
    PrivateKey privateKey = PrivateKey(keypair.privateKey.bytes);
    PublicKey publicKey = PublicKey(keypair.publicKey.bytes);
    return KeyPair(privateKey, publicKey);
  }

  static String publicKeyToString(ed.PublicKey keyPair) {
    return base58.encode(Uint8List.fromList(keyPair.bytes));
  }
}
