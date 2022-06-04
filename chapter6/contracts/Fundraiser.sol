// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
import "../node_modules/openzeppelin-solidity/contracts/access/Ownable.sol";
// SafeMath .. 整数型の変数の境界を越える恐れがある算術演算を行う時に使用！
import "../node_modules/openzeppelin-solidity/contracts/utils/math/SafeMath.sol";
// 新しい資金調達を作成するのに必要なもの　↓ (状態変数)

// 受取人の名前
// ユーザが詳細を確認できるWebサイト
// 受取人のアドレス（資金を受け取れるアドレス）
// Topページのカードに使う画像のURL
// 受取人に関する簡単な説明
// 管理人またはownerのアドレス

contract FundRaiser is Ownable{
    // 寄付者のアドレスと金額をとる。
    // indexed .. EVMでサブスクライバが自分に関係があるかもしれないイベントを絞り込みやすくなる。
    // event はチェーンにデータを格納するコスト効率の良い手段（ガス消費が低い）
    event DonationReceived(address indexed donor, uint256 value);
    event Withdraw(uint256 amount);

    using SafeMath for uint256;
    uint256 public totalDonations;
    uint256 public donationsCount;

    struct Donation {
        uint256 value;
        uint256 date;
    }
    mapping(address => Donation[]) private _donations;

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
    function myDonationsCount() public view returns(uint256) {
        return _donations[msg.sender].length;
    }
    function donate() public payable{
        Donation memory donation = Donation({
            value : msg.value,
            date : block.timestamp
        });
        _donations[msg.sender].push(donation);
        totalDonations = totalDonations.add(msg.value);
        donationsCount++;

        emit DonationReceived(msg.sender, msg.value);
    }
    function myDonations() public view returns(
        uint256[] memory values,
        uint256[] memory dates
    )
    {
        uint256 count = myDonationsCount(); //message送信者の寄付の件数を取得。 ..配列に必要な大きさがわかる。
        // new　を使いインメモリで作成。
        values = new uint256[](count);
        dates = new uint256[](count);

        for (uint256 i = 0; i < count; i++){
            // storageの理由..新しい構造体をインメモリではなくコントラクトの状態変数に既に保存されている構造体を参照しているから。
            Donation storage donation = _donations[msg.sender][i];
            values[i] = donation.value;
            dates[i] = donation.date;
        }
        return (values, dates);
    }
    function withdraw() public onlyOwner{
        uint256 balance = address(this).balance;
        beneficiary.transfer(balance);
        emit Withdraw(balance);
    }
    fallback () external payable{
        totalDonations = totalDonations.add(msg.value);
        donationsCount++;
    }

}

// 構造体、キーワード構文（dictionary）などで新しい型を定義できる。
// キーワードの方が明示的に分かちやすい。順序に依存しないからこっちを採用する！！
// mapping でもキーと値の関連付けが可能。
// Ex. mapping(address Donation[]) private _donation;