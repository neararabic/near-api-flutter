// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signature.dart';

// **************************************************************************
// BorshSerializableGenerator
// **************************************************************************

mixin _$Signature {
  int get keyType => throw UnimplementedError();
  List<int> get data => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BU8().write(writer, keyType);
    const BFixedArray(64, BU8()).write(writer, data);

    return writer.toArray();
  }
}

class _Signature extends Signature {
  _Signature({
    required this.keyType,
    required this.data,
  }) : super._();

  final int keyType;
  final List<int> data;
}

class BSignature implements BType<Signature> {
  const BSignature();

  @override
  void write(BinaryWriter writer, Signature value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  Signature read(BinaryReader reader) {
    return Signature(
      keyType: const BU8().read(reader),
      data: const BFixedArray(64, BU8()).read(reader),
    );
  }
}

Signature _$SignatureFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BSignature().read(reader);
}
