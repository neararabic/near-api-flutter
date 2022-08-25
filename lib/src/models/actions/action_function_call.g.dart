// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_function_call.dart';

// **************************************************************************
// BorshSerializableGenerator
// **************************************************************************

mixin _$FunctionCallAction {
  int get actionNumber => throw UnimplementedError();
  FunctionCallActionArgs get functionCallActionArgs =>
      throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BU8().write(writer, actionNumber);
    const BFunctionCallActionArgs().write(writer, functionCallActionArgs);

    return writer.toArray();
  }
}

class _FunctionCallAction extends FunctionCallAction {
  _FunctionCallAction({
    required this.actionNumber,
    required this.functionCallActionArgs,
  }) : super._();

  final int actionNumber;
  final FunctionCallActionArgs functionCallActionArgs;
}

class BFunctionCallAction implements BType<FunctionCallAction> {
  const BFunctionCallAction();

  @override
  void write(BinaryWriter writer, FunctionCallAction value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  FunctionCallAction read(BinaryReader reader) {
    return FunctionCallAction(
      actionNumber: const BU8().read(reader),
      functionCallActionArgs: const BFunctionCallActionArgs().read(reader),
    );
  }
}

FunctionCallAction _$FunctionCallActionFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BFunctionCallAction().read(reader);
}

mixin _$FunctionCallActionArgs {
  String get methodName => throw UnimplementedError();
  String get args => throw UnimplementedError();
  BigInt get gas => throw UnimplementedError();
  List<int> get deposit => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BString().write(writer, methodName);
    const BString().write(writer, args);
    const BU64().write(writer, gas);
    const BFixedArray(16, BU8()).write(writer, deposit);

    return writer.toArray();
  }
}

class _FunctionCallActionArgs extends FunctionCallActionArgs {
  _FunctionCallActionArgs({
    required this.methodName,
    required this.args,
    required this.gas,
    required this.deposit,
  }) : super._();

  final String methodName;
  final String args;
  final BigInt gas;
  final List<int> deposit;
}

class BFunctionCallActionArgs implements BType<FunctionCallActionArgs> {
  const BFunctionCallActionArgs();

  @override
  void write(BinaryWriter writer, FunctionCallActionArgs value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  FunctionCallActionArgs read(BinaryReader reader) {
    return FunctionCallActionArgs(
      methodName: const BString().read(reader),
      args: const BString().read(reader),
      gas: const BU64().read(reader),
      deposit: const BFixedArray(16, BU8()).read(reader),
    );
  }
}

FunctionCallActionArgs _$FunctionCallActionArgsFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BFunctionCallActionArgs().read(reader);
}
