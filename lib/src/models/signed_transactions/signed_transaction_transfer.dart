import 'package:borsh_annotation/borsh_annotation.dart';
import '../signature/signature.dart';
import '../transactions/transaction_transfer.dart';

part 'signed_transaction_transfer.g.dart';

@BorshSerializable()
class SignedTransferTransaction with _$SignedTransferTransaction {
  factory SignedTransferTransaction({
    @BTransferTransaction() required TransferTransaction transferTransaction,
    @BSignature() required Signature signature,
  }) = _SignedTransferTransaction;

  SignedTransferTransaction._();

  factory SignedTransferTransaction.fromBorsh(Uint8List data) =>
      _$SignedTransferTransactionFromBorsh(data);
}