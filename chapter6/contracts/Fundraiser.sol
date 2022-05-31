// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
import "../node_modules/openzeppelin-solidity/contracts/access/Ownable.sol";
// 新しい資金調達を作成するのに必要なもの　↓ (状態変数)

// 受取人の名前
// ユーザが詳細を確認できるWebサイト
// 受取人のアドレス（資金を受け取れるアドレス）
// Topページのカードに使う画像のURL
// 受取人に関する簡単な説明
// 管理人またはownerのアドレス

contract FundRaiser is Ownable{   
    // contract に状態変数の追加
    string public name;
    string public url;
    string public imageURL;
    string public description;
    address payable public beneficiary;
    constructor (string memory _name, 
                string memory _url, 
                string memory _imageURL,
                string memory _description, 
                address payable _beneficiary,
                address _custodian
                ) public 
                {
        name = _name;
        url = _url;
        imageURL = _imageURL;
        description = _description;
        beneficiary = _beneficiary;
        transferOwnership(_custodian);
    }
    function setBeneficiary (address payable _beneficiary) public onlyOwner {
        beneficiary = _beneficiary;
    }
}

