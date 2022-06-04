// deployのテストケースを追加
const FundraiserFactoryContract = artifacts.require("FundraiserFactory");

contract("FundraiserFactory: deployment", () => {
  it("has been deployed", async () => {
    const fundraiserFactory = FundraiserFactoryContract.deployed();
    assert(fundraiserFactory, "fundraiser factory was not deployed");
  });
});
// formから入力された資金調達データを保持する変数を設定。
contract("FundraiserFactory: createFundraiser", (accounts) => {
  let fundraiserFactory;
  // Fundraiserの引数
  const name = "Beneficiary";
  const url = "beneficiaryname.org";
  const imageURL = "https://placekitten.com/600/350";
  const description = "Beneficiary Description";
  const beneficiary = accounts[1];

  it("increments the fundraisersCount", async () => {
    fundraiserFactory = await FundraiserFactoryContract.deployed();
    const currentFundraisersCount = await fundraiserFactory.fundraisersCount();
    await fundraiserFactory.createFundraiser(
      name,
      url,
      imageURL,
      description,
      beneficiary
    );
    const newFundraisersCount = await fundraiserFactory.fundraisersCount();
    assert.equal(
      newFundraisersCount - currentFundraisersCount,
      1,
      "should increment by 1"
    );
  });
});
