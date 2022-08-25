// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signed_transaction_function_call.dart';

// **************************************************************************
// BorshSerializableGenerator
// **************************************************************************

mixin _$SignedFunctionCallTransaction {
  FunctionCallTransaction get functionCallTransaction =>
      throw UnimplementedError();
  Signature get signature => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BFunctionCallTransaction().write(writer, functionCallTransaction);
    const BSignature().write(writer, signature);

    return writer.toArray();
  }
}

class _SignedFunctionCallTransaction extends SignedFunctionCallTransaction {
  _SignedFunctionCallTransaction({
    required this.functionCallTransaction,
    required this.signature,
  }) : super._();

  final FunctionCallTransaction functionCallTransaction;
  final Signature signature;
}

class BSignedFunctionCallTransaction
    implements BType<SignedFunctionCallTransaction> {
  const BSignedFunctionCallTransaction();

  @override
  void write(BinaryWriter writer, SignedFunctionCallTransaction value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  SignedFunctionCallTransaction read(BinaryReader reader) {
    return SignedFunctionCallTransaction(
      functionCallTransaction: const BFunctionCallTransaction().read(reader),
      signature: const BSignature().read(reader),
    );
  }
}

SignedFunctionCallTransaction _$SignedFunctionCallTransactionFromBorsh(
    Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BSignedFunctionCallTransaction().read(reader);
}
