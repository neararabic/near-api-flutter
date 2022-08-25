// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_transfer.dart';

// **************************************************************************
// BorshSerializableGenerator
// **************************************************************************

mixin _$TransferTransaction {
  String get signerId => throw UnimplementedError();
  PublicKey get publicKey => throw UnimplementedError();
  BigInt get nonce => throw UnimplementedError();
  String get receiverId => throw UnimplementedError();
  List<int> get blockHash => throw UnimplementedError();
  List<TransferAction> get transferActions => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BString().write(writer, signerId);
    const BPublicKey().write(writer, publicKey);
    const BU64().write(writer, nonce);
    const BString().write(writer, receiverId);
    const BFixedArray(32, BU8()).write(writer, blockHash);
    const BArray(BTransferAction()).write(writer, transferActions);

    return writer.toArray();
  }
}

class _TransferTransaction extends TransferTransaction {
  _TransferTransaction({
    required this.signerId,
    required this.publicKey,
    required this.nonce,
    required this.receiverId,
    required this.blockHash,
    required this.transferActions,
  }) : super._();

  final String signerId;
  final PublicKey publicKey;
  final BigInt nonce;
  final String receiverId;
  final List<int> blockHash;
  final List<TransferAction> transferActions;
}

class BTransferTransaction implements BType<TransferTransaction> {
  const BTransferTransaction();

  @override
  void write(BinaryWriter writer, TransferTransaction value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  TransferTransaction read(BinaryReader reader) {
    return TransferTransaction(
      signerId: const BString().read(reader),
      publicKey: const BPublicKey().read(reader),
      nonce: const BU64().read(reader),
      receiverId: const BString().read(reader),
      blockHash: const BFixedArray(32, BU8()).read(reader),
      transferActions: const BArray(BTransferAction()).read(reader),
    );
  }
}

TransferTransaction _$TransferTransactionFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BTransferTransaction().read(reader);
}
