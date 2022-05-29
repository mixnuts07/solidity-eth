// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Greeter {
  string private _greeting  ="Hello, World!";
  address private _owner;
  constructor () public {
  // msg.sender .. 初期化時に所有者として記録
    _owner = msg.sender;
  }
  modifier onlyOwner() {
    require(msg.sender == _owner,
    "Ownable : caller is not the owner"
    );
    // _; .. 修飾されている関数がcallされる場所。　関数の本体の実行が完了した後に実行される。
    _;
  }
  function greet() external view returns(string memory){
    return _greeting;
  }
  //　setGreeting .. contractの状態を新しい挨拶文で更新する
  // calldata .. dataの保管場所
  function setGreeting(string calldata greeting) external onlyOwner {
    _greeting = greeting;

  }
  function owner() public view returns(address){
    return _owner;
  }
}
