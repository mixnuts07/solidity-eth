// web3 
//.. Ethノードをリモートorローカルで操作できるJSライブラリの集まり。　チェーンを簡単に操作できるようにするAPIを提供。　
// → Ethチェーンとスマートコントラクトの橋渡しをする！
// 内部で JSON-RPC を使う。　（Remote Procedure Call）

// web2.0アプリ
// Frontend　⇄ Backend ⇄ DB

// web3.0アプリ
// Frontend　⇄ Web3 ⇄ ブロックチェーン


// web3メソッド（Ex）

web3.eth.getAccounts();
// 自分が管理しているWeb3ウォレットのアドレスのリストを取得できる！  ロックされていないウォレットだけ返される。

web3.eth.getBlockNumber().then(console.log());  //8911
// 現在のブロック番号を返す！

web3.eth.getBalance("0xfjiwehfiojkas1998e11i9").then(console.log()); // "200000"
// アドレスの残高を調べる！

web3.eth.sendTransaction({
  from : "0xji13urwjf8138981",
  to   : "0x3y189jde3ijrfejf",
  value: web3.toWei(1, "ether"),
  })
// アドレス間での送金！

new Web3(new Web3.providers.HttpProvider("https://localhost:85845"))
// Web3を使うときプロバイダを設定することで、Web3がどのノードに接続すればよいかがわかるようにしておく！！
// 上だとlocalhostに接続される！

currentProvider()
// 現在のプロバイダを返す！


//プロバイダ .. プロジェクトがチェーンと対話できるようにする仕組み。　やりとりの対象になるノードをプロジェクトに知らせる。　　URLみたいなもの！
// プロバイダはRPC命令を正しいEthノードに送信する！


// ユーザの残高を調べる
return new Promise (function (resolve, reject) {
  web3.eth.getBalance("0xa7319..", function (err, balance) {
    if (error) {
      reject(error)
    } else {
      resolve(balance)
    }
  })
})


// sendメソッド（web3の一つ）　チェーンに何か追加したい時に使う。
// ユーザにMetaMaskを使い、トランザクションに署名し、ガス手数料を支払うことを要求する。

// callメソッド .. view / pure 関数で使う！　
// ガス代なし！　MetaMaskの署名もなし！
// チェーン上にトランザクションを作成せず、何も発行しない！



