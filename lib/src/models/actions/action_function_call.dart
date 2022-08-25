import 'package:borsh_annotation/borsh_annotation.dart';
part 'action_function_call.g.dart';

@BorshSerializable()
class FunctionCallAction with _$FunctionCallAction {
  factory FunctionCallAction({
    @BU8() required int actionNumber,
    // 0: CreateAccount;
    // 1: DeployContract;
    // 2: FunctionCall;
    // 3: Transfer;
    // 4: Stake;
    // 5: AddKey;
    // 6: DeleteKey;
    // 7: DeleteAccount;
    @BFunctionCallActionArgs() required FunctionCallActionArgs functionCallActionArgs,
  }) = _FunctionCallAction;

  FunctionCallAction._();

  factory FunctionCallAction.fromBorsh(Uint8List data) =>
      _$FunctionCallActionFromBorsh(data);
}

@BorshSerializable()
class FunctionCallActionArgs with _$FunctionCallActionArgs {
  factory FunctionCallActionArgs({
    @BString() required String methodName,
    @BString() required String args,
    @BU64() required BigInt gas,
    @BFixedArray(16, BU8()) required List<int> deposit,
  }) = _FunctionCallActionArgs;

  FunctionCallActionArgs._();

  factory FunctionCallActionArgs.fromBorsh(Uint8List data) =>
      _$FunctionCallActionArgsFromBorsh(data);
}

