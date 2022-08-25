import 'package:borsh_annotation/borsh_annotation.dart';

part 'signature.g.dart';

@BorshSerializable()
class Signature with _$Signature {
  factory Signature({
    @BU8() required int keyType,
    // ED25519 = 0,
    @BFixedArray(64, BU8()) required List<int> data,
  }) = _Signature;

  Signature._();

  factory Signature.fromBorsh(Uint8List data) => _$SignatureFromBorsh(data);
}
