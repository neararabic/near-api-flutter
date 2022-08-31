import 'package:borsh_annotation/borsh_annotation.dart';

part 'transaction_result.g.dart';

@BorshSerializable()
class TransactionResult with _$TransactionResult {
  factory TransactionResult({
    @BString() required String receiver,
    @BString() required String sender,
    @BString() required String content,
  }) = _TransactionResult;

  TransactionResult._();

  factory TransactionResult.fromBorsh(Uint8List data) =>
      _$TransactionResultFromBorsh(data);
}
