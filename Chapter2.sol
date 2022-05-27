・トークン .. 所有権を表す抽象概念。所有権の証明。　所有権は頻繁に変更できるから、追跡可能性に意味がある。

・EIPプロセス .. 開発者によるトークン作成支援。　ERC-20,ERC-721規格などがある。
・ERC-20 .. ファンジブル（相互に交換可能なトークン）を作成するときに使う。 トークンは全て同じ価値を持つとみなされ、区別されない。　残高追跡、通貨、ICOなど。
totalSupply()
 流通してるトークン数
balanceOf(address _owner)
 指定アドレスの残高
transfer(address _to, uint256 _value)
 送金の成功or失敗で true or false
transferFrom(address _from, address _to, uint256 _value)
 送金の成功or失敗で true or false
 送金は所有者ではなく、別のアドレスから開始。代理人として事前承認が必要。
approve(address _spender, uitn256 _value)
 承認の成功or失敗で true or false
 代理人が使える金額を設定
allowance(address _owner, address _sprender)
　承認されたアドレスが引き出せる金額
 
 上でERC-20のトークンを作成できるが、OpenZeooelinのコントラクトをベースとして作業を始めた方が良い。
 
 
・ERC-721 .. NFTの規格。各トークンが異なっているため、コントラクトがトークンの残高を追跡することが不可能。発光するトークンを個別に追跡しないといけない！
balanceOf(address _owner)
 指定された所有者のNFTの数を返す
ownerOf(uitn256 _tokenId)
 特定のトークンIDの所有者のアドレスを返す
safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes data)
 トークンの所有権を譲渡。
transferFrom(address _from, address _to, uint256 _tokenId)
 トークンの所有権を譲渡。
approve(address _approved, uint256 _tokenId)
 別のアドレスが所有者の代理としてトークンを送金できるようにする。
setApprovalForAll(address _operator, bool _approved)
 コントラクトからのトークンを全て管理。
getApproved(uint256 _tokenId)
 トークンIDに対して承認されているアドレスを返す。
iSApprovedForAll(address _owner, address _operator)
 アドレスがオペレータとして承認されてるか確認。

 
 ・Etherscan .. ブラウザで全てのブロックとトランザクションを検査できる。
 
 
 
 
 
