import 'package:borsh_annotation/borsh_annotation.dart';
part 'action_transfer.g.dart';


@BorshSerializable()
class TransferAction with _$TransferAction {
  factory TransferAction({
    @BU8() required int actionNumber,
    // 0: CreateAccount;
    // 1: DeployContract;
    // 2: FunctionCall;
    // 3: Transfer;
    // 4: Stake;
    // 5: AddKey;
    // 6: DeleteKey;
    // 7: DeleteAccount;
    @BTransferActionArgs() required TransferActionArgs transferActionArgs,
  }) = _TransferAction;

  TransferAction._();

  factory TransferAction.fromBorsh(Uint8List data) =>
      _$TransferActionFromBorsh(data);
}
@BorshSerializable()
class TransferActionArgs with _$TransferActionArgs {
  factory TransferActionArgs({
    @BFixedArray(16, BU8()) required List<int> deposit,
  }) = _TransferActionArgs;

  TransferActionArgs._();

  factory TransferActionArgs.fromBorsh(Uint8List data) => _$TransferActionArgsFromBorsh(data);
}
