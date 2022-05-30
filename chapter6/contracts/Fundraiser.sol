// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
// 新しい資金調達を作成するのに必要なもの　↓ (状態変数)

// 受取人の名前
// ユーザが詳細を確認できるWebサイト
// 受取人のアドレス（資金を受け取れるアドレス）
// Topページのカードに使う画像のURL
// 受取人に関する簡単な説明
// 管理人またはownerのアドレス

contract FundRaiser {   
    // contract に状態変数の追加
    string public name;
    string public url;
    string public imageURL;
    string public description;
    constructor (string memory _name, string memory _url, string memory _imageURL, string memory _description) public {
        name = _name;
        url = _url;
        imageURL = imageURL;
        description = _description;
    }
}

