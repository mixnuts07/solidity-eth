const FundraiserContract = artifacts.require("Fundraiser");

contract("Fundraiser", (accounts) => {
  let fundraiser; // 資金調達を格納する変数
  const name = "Beneficiary Name"; // 受取人の名前
  const url = "beneficiaryname.org";
  const imageURL = "https://placekitten.com/600/350";
  const description = "Beneficiary description";

  describe("initialization", () => {
    // beforeEach .. 各テストサンプルが実行される前に資金調達を設定。
    beforeEach(async () => {
      fundraiser = await FundraiserContract.new(
        name,
        url,
        imageURL,
        description
      );
    });
    // getter で　データが正しく設定されているか確認
    it("gets the beneficiary name", async () => {
      const actual = await fundraiser.name();
      assert.equal(actual, name, "name should match");
    });
    it("gets the beneficiary url", async () => {
      const actual = await fundraiser.url();
      assert.equal(actual, url, "url should match");
    });
    // it("gets the beneficiary image url", async () => {
    //   const actual = await fundraiser.imageURL();
    //   assert.equal(actual, imageURL, "imageURL should match");
    // });
    it("gets the beneficiary description", async () => {
      const actual = await fundraiser.description();
      assert.equal(actual, description, "description should match");
    });
  });
});
