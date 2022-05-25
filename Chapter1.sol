・Ethのスマートコントラクト開発に必要
①イーサリアムプロトコルのサブセット
②Solidity
③イーサリアム仮想マシン（EVM)

 【ブロックチェーンの概念】

・ブロックチェーン .. データ構造。一意のブロックを連結したリスト（チェーン）
価値交換のトランザクションがP2Pネットワークに送信され、定期的にブロックにまとめられる。
・ブロック .. 永続化されるときに１つ前のブロックにチェーンされる。（追加専用のトランザクション）
・スマートコントラクト .. 暗号によって保護されたプラットフォームを提供する。　→ チェーンのデータを格納・保護・削除するためのもの。
スマートコントラクトは法的契約に特化というよりは、汎用的なプログラミングに近い。
Ethプロトコルが定義している仮想マシンはチューリング完全である。→計算を１つのブロックの制限内に収めることができれば、想像以上の制約はない。

一般的なDBとは異なり、スマートコントラクトはやりとりが瞬時に行われるわけでもなく、恒久的であることは保証されない。
Solidityをサーバー言語のように扱うことはできない。

・ノード ... PCにインストールし、ブロックチェーンネットワークに接続しているソフトウェアのことを指す。
WebサーバーというHTTPプロトコルのソフトウェアにも色々あるように（Apache, NGINX）
イーサリアムノードと呼ばれるイーサリアムプロトコルのソフトウェアのも色々ある。（geth, Parity）


・ブロックチェーンは非中央集権ネットワークで動作する。
→　人や企業はネットワーク上でノードを実行する。　これらのノードはpeerである。