class AccessKey {
  String blockHash;
  int blockHeight;
  int nonce;

  AccessKey(this.blockHash, this.blockHeight, this.nonce);

  static AccessKey fromJson(json) =>
      AccessKey(json['block_hash'], json['block_height'], json['nonce']);
}
