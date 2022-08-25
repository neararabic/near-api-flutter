// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_transfer.dart';

// **************************************************************************
// BorshSerializableGenerator
// **************************************************************************

mixin _$TransferAction {
  int get actionNumber => throw UnimplementedError();
  TransferActionArgs get transferActionArgs => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BU8().write(writer, actionNumber);
    const BTransferActionArgs().write(writer, transferActionArgs);

    return writer.toArray();
  }
}

class _TransferAction extends TransferAction {
  _TransferAction({
    required this.actionNumber,
    required this.transferActionArgs,
  }) : super._();

  final int actionNumber;
  final TransferActionArgs transferActionArgs;
}

class BTransferAction implements BType<TransferAction> {
  const BTransferAction();

  @override
  void write(BinaryWriter writer, TransferAction value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  TransferAction read(BinaryReader reader) {
    return TransferAction(
      actionNumber: const BU8().read(reader),
      transferActionArgs: const BTransferActionArgs().read(reader),
    );
  }
}

TransferAction _$TransferActionFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BTransferAction().read(reader);
}

mixin _$TransferActionArgs {
  List<int> get deposit => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BFixedArray(16, BU8()).write(writer, deposit);

    return writer.toArray();
  }
}

class _TransferActionArgs extends TransferActionArgs {
  _TransferActionArgs({
    required this.deposit,
  }) : super._();

  final List<int> deposit;
}

class BTransferActionArgs implements BType<TransferActionArgs> {
  const BTransferActionArgs();

  @override
  void write(BinaryWriter writer, TransferActionArgs value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  TransferActionArgs read(BinaryReader reader) {
    return TransferActionArgs(
      deposit: const BFixedArray(16, BU8()).read(reader),
    );
  }
}

TransferActionArgs _$TransferActionArgsFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BTransferActionArgs().read(reader);
}
