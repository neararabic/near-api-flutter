import 'dart:typed_data';
import 'package:bs58/bs58.dart';
import 'package:ed25519_edwards/ed25519_edwards.dart' as ed;

/// Holds user private Key
class PrivateKey extends ed.PrivateKey {
  PrivateKey(super.bytes);
}

/// Holds user public Key
class PublicKey extends ed.PublicKey {
  PublicKey(super.bytes);
}

/// Stores the user private and public keys
class KeyPair extends ed.KeyPair {
  // ignore: overridden_fields, annotate_overrides
  PrivateKey privateKey;
  // ignore: annotate_overrides, overridden_fields
  PublicKey publicKey;

  KeyPair(this.privateKey, this.publicKey) : super(privateKey, publicKey);
}

/// Utility class to generate keypair and get public key
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
