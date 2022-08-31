// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_result.dart';

// **************************************************************************
// BorshSerializableGenerator
// **************************************************************************

mixin _$TransactionResult {
  String get receiver => throw UnimplementedError();
  String get sender => throw UnimplementedError();
  String get content => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BString().write(writer, receiver);
    const BString().write(writer, sender);
    const BString().write(writer, content);

    return writer.toArray();
  }
}

class _TransactionResult extends TransactionResult {
  _TransactionResult({
    required this.receiver,
    required this.sender,
    required this.content,
  }) : super._();

  final String receiver;
  final String sender;
  final String content;
}

class BTransactionResult implements BType<TransactionResult> {
  const BTransactionResult();

  @override
  void write(BinaryWriter writer, TransactionResult value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  TransactionResult read(BinaryReader reader) {
    return TransactionResult(
      receiver: const BString().read(reader),
      sender: const BString().read(reader),
      content: const BString().read(reader),
    );
  }
}

TransactionResult _$TransactionResultFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BTransactionResult().read(reader);
}
