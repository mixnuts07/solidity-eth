const FundraiserContract = artifacts.require("Fundraiser");

contract("Fundraiser", (accounts) => {
  let fundraiser; // 資金調達を格納する変数
  const name = "Beneficiary Name"; // 受取人の名前

  describe("initialization", () => {
    // beforeEach .. 各テストサンプルが実行される前に資金調達を設定。
    beforeEach(async () => {
      fundraiser = await FundraiserContract.new(name);
    });
  });
});
