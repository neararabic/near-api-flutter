// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signed_transaction_transfer.dart';

// **************************************************************************
// BorshSerializableGenerator
// **************************************************************************

mixin _$SignedTransferTransaction {
  TransferTransaction get transferTransaction => throw UnimplementedError();
  Signature get signature => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BTransferTransaction().write(writer, transferTransaction);
    const BSignature().write(writer, signature);

    return writer.toArray();
  }
}

class _SignedTransferTransaction extends SignedTransferTransaction {
  _SignedTransferTransaction({
    required this.transferTransaction,
    required this.signature,
  }) : super._();

  final TransferTransaction transferTransaction;
  final Signature signature;
}

class BSignedTransferTransaction implements BType<SignedTransferTransaction> {
  const BSignedTransferTransaction();

  @override
  void write(BinaryWriter writer, SignedTransferTransaction value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  SignedTransferTransaction read(BinaryReader reader) {
    return SignedTransferTransaction(
      transferTransaction: const BTransferTransaction().read(reader),
      signature: const BSignature().read(reader),
    );
  }
}

SignedTransferTransaction _$SignedTransferTransactionFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BSignedTransferTransaction().read(reader);
}
