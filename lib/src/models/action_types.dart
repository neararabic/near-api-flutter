enum ActionType{
  createAccount(0),
  deployContract(1),
  functionCall(2),
  transfer(3),
  stake(4),
  addKey(5),
  deleteKey(6),
  deleteAccount(7);

  const ActionType(this.value);
  final int value;

  static ActionType getByValue(int i){
    return ActionType.values.firstWhere((x) => x.value == i);
  }
}