import 'package:borsh_annotation/borsh_annotation.dart';
part 'public_key.g.dart';

@BorshSerializable()
class PublicKey with _$PublicKey {
  factory PublicKey({
    @BU8() required int keyType,
    @BFixedArray(32, BU8()) required List<int> data,
  }) = _PublicKey;

  PublicKey._();

  factory PublicKey.fromBorsh(Uint8List data) =>
      _$PublicKeyFromBorsh(data);
}