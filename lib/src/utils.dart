import 'dart:typed_data';

class Utils{
  static int _binaryStringToInt(String binaryString) {
    final pattern = RegExp(r'(?:0x)?(\d+)');
    return int.parse(pattern.firstMatch(binaryString)!.group(1)!, radix: 2);
  }

  static Uint8List decodeNearDeposit(String amount) {
    double nearAmount = 1000000000000.0 * double.parse(amount);
    BigInt nearBigNumber = BigInt.parse("${nearAmount.toStringAsFixed(0)}000000000000");
    String nearBinary = nearBigNumber.toRadixString(2);
    String nearU128Binary = nearBinary.padLeft(128, '0');
    List near8BitList = [];
    const divisionIndex = 8;
    for (int i = 0; i < nearU128Binary.length; i++) {
      if (i % divisionIndex == 0) {
        near8BitList.add(nearU128Binary.substring(i, i + divisionIndex));
      }
    }
    final deposit = Uint8List(16);
    for (int i = 0; i < near8BitList.length; i++) {
      deposit[(deposit.length - 1) - i] = _binaryStringToInt(near8BitList[i]);
    }
    return deposit;
  }

}