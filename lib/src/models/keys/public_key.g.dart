// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_key.dart';

// **************************************************************************
// BorshSerializableGenerator
// **************************************************************************

mixin _$PublicKey {
  int get keyType => throw UnimplementedError();
  List<int> get data => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BU8().write(writer, keyType);
    const BFixedArray(32, BU8()).write(writer, data);

    return writer.toArray();
  }
}

class _PublicKey extends PublicKey {
  _PublicKey({
    required this.keyType,
    required this.data,
  }) : super._();

  final int keyType;
  final List<int> data;
}

class BPublicKey implements BType<PublicKey> {
  const BPublicKey();

  @override
  void write(BinaryWriter writer, PublicKey value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  PublicKey read(BinaryReader reader) {
    return PublicKey(
      keyType: const BU8().read(reader),
      data: const BFixedArray(32, BU8()).read(reader),
    );
  }
}

PublicKey _$PublicKeyFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BPublicKey().read(reader);
}
