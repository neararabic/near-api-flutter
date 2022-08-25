import 'package:borsh_annotation/borsh_annotation.dart';
import '../actions/action_function_call.dart';
import '../keys/public_key.dart';
part 'transaction_function_call.g.dart';

@BorshSerializable()
class FunctionCallTransaction with _$FunctionCallTransaction {
  factory FunctionCallTransaction({
    @BString() required String signerId,
    @BPublicKey() required PublicKey publicKey,
    @BU64() required BigInt nonce,
    @BString() required String receiverId,
    @BFixedArray(32, BU8()) required List<int> blockHash,
    @BArray(BFunctionCallAction())
        required List<FunctionCallAction> functionCallActions,
  }) = _FunctionCallTransaction;

  FunctionCallTransaction._();

  factory FunctionCallTransaction.fromBorsh(Uint8List data) =>
      _$FunctionCallTransactionFromBorsh(data);
}
