import 'package:borsh_annotation/borsh_annotation.dart';
import '../keys/public_key.dart';
import '../actions/action_transfer.dart';
part 'transaction_transfer.g.dart';

@BorshSerializable()
class TransferTransaction with _$TransferTransaction {
  factory TransferTransaction({
    @BString() required String signerId,
    @BPublicKey() required PublicKey publicKey,
    @BU64() required BigInt nonce,
    @BString() required String receiverId,
    @BFixedArray(32, BU8()) required List<int> blockHash,
    @BArray(BTransferAction()) required List<TransferAction> transferActions,
  }) = _TransferTransaction;

  TransferTransaction._();

  factory TransferTransaction.fromBorsh(Uint8List data) =>
      _$TransferTransactionFromBorsh(data);
}