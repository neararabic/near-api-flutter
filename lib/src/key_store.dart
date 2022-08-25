import 'dart:typed_data';
import 'package:bs58/bs58.dart';
import 'package:ed25519_edwards/ed25519_edwards.dart' as ed;

class KeyStore {

  static ed.KeyPair newKeyPair(){
    return ed.generateKey();
  }

  static String publicKeyToString(ed.PublicKey keyPair) {
      return base58.encode(Uint8List.fromList(keyPair.bytes));

  }
}