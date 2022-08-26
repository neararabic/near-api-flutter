class AccessKey {
  String blockHash;
  int blockHeight;
  int nonce;
  Map<String, dynamic> permission;

  AccessKey(this.blockHash, this.blockHeight, this.nonce, this.permission);

  static AccessKey fromJson(json) => AccessKey(json['block_hash'], json['block_height'], json['nonce'], json['permission']);
}
