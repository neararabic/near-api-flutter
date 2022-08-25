// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_function_call.dart';

// **************************************************************************
// BorshSerializableGenerator
// **************************************************************************

mixin _$FunctionCallTransaction {
  String get signerId => throw UnimplementedError();
  PublicKey get publicKey => throw UnimplementedError();
  BigInt get nonce => throw UnimplementedError();
  String get receiverId => throw UnimplementedError();
  List<int> get blockHash => throw UnimplementedError();
  List<FunctionCallAction> get functionCallActions =>
      throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BString().write(writer, signerId);
    const BPublicKey().write(writer, publicKey);
    const BU64().write(writer, nonce);
    const BString().write(writer, receiverId);
    const BFixedArray(32, BU8()).write(writer, blockHash);
    const BArray(BFunctionCallAction()).write(writer, functionCallActions);

    return writer.toArray();
  }
}

class _FunctionCallTransaction extends FunctionCallTransaction {
  _FunctionCallTransaction({
    required this.signerId,
    required this.publicKey,
    required this.nonce,
    required this.receiverId,
    required this.blockHash,
    required this.functionCallActions,
  }) : super._();

  final String signerId;
  final PublicKey publicKey;
  final BigInt nonce;
  final String receiverId;
  final List<int> blockHash;
  final List<FunctionCallAction> functionCallActions;
}

class BFunctionCallTransaction implements BType<FunctionCallTransaction> {
  const BFunctionCallTransaction();

  @override
  void write(BinaryWriter writer, FunctionCallTransaction value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  FunctionCallTransaction read(BinaryReader reader) {
    return FunctionCallTransaction(
      signerId: const BString().read(reader),
      publicKey: const BPublicKey().read(reader),
      nonce: const BU64().read(reader),
      receiverId: const BString().read(reader),
      blockHash: const BFixedArray(32, BU8()).read(reader),
      functionCallActions: const BArray(BFunctionCallAction()).read(reader),
    );
  }
}

FunctionCallTransaction _$FunctionCallTransactionFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BFunctionCallTransaction().read(reader);
}
