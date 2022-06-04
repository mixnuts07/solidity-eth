const FundraiserContract = artifacts.require("Fundraiser");

contract("Fundraiser", (accounts) => {
  let fundraiser; // 資金調達を格納する変数
  const name = "Beneficiary Name"; // 受取人の名前
  const url = "beneficiaryname.org";
  const imageURL = "https://placekitten.com/600/350";
  const description = "Beneficiary description";
  const beneficiary = accounts[1];
  const owner = accounts[0];

  // beforeEach .. 各テストサンプルが実行される前に資金調達を設定。
  beforeEach(async () => {
    fundraiser = await FundraiserContract.new(
      name,
      url,
      imageURL,
      description,
      beneficiary,
      owner
    );
  });

  describe("initialization", () => {
    // getter で　データが正しく設定されているか確認
    it("gets the beneficiary name", async () => {
      const actual = await fundraiser.name();
      assert.equal(actual, name, "name should match");
    });
    it("gets the beneficiary url", async () => {
      const actual = await fundraiser.url();
      assert.equal(actual, url, "url should match");
    });
    it("gets the beneficiary image url", async () => {
      const actual = await fundraiser.imageURL();
      assert.equal(actual, imageURL, "imageURL should match");
    });
    it("gets the beneficiary description", async () => {
      const actual = await fundraiser.description();
      assert.equal(actual, description, "description should match");
    });
    it("gets the beneficiary", async () => {
      const actual = await fundraiser.beneficiary();
      assert.equal(actual, beneficiary, "beneficiary should match");
    });
    it("gets the beneficiary owner", async () => {
      const actual = await fundraiser.owner();
      assert.equal(actual, owner, "owner should match");
    });
  });
  describe("setBeneficiary", () => {
    const newBeneficiary = accounts[2];

    it("updated beneficiary when called by owner account", async () => {
      await fundraiser.setBeneficiary(newBeneficiary, { from: owner });
      const actualBeneficiary = await fundraiser.beneficiary();
      assert.equal(
        actualBeneficiary,
        newBeneficiary,
        "beneficiary should match"
      );
    });
    it("throws and error when called from a non-owner account", async () => {
      try {
        await fundraiser.setBeneficiary(newBeneficiary, { from: accounts[3] });
        assert.fail("withdraw was not restricted to owners");
      } catch (err) {
        const expectedError = "Ownable: caller is not the owner";
        const actualError = err.reason;
        assert.equal(actualError, expectedError, "should not be permitted");
      }
    });
  });
  describe("making donations", () => {
    const value = web3.utils.toWei("0.0289"); // 寄付の金額
    const donor = accounts[2]; // 寄付者のアドレス
    // 特定の寄付者について現在の寄付件数を取得し、その寄付者から寄付を行った後、再び寄付件数をチェックする。 → 寄付の件数を返す！
    it("increase myDonationsCount", async () => {
      const currentDonationsCount = await fundraiser.myDonationsCount({
        from: donor,
      });
      await fundraiser.donate({ from: donor, value });

      const newDonationsCount = await fundraiser.myDonationsCount({
        from: donor,
      });
      assert.equal(
        1,
        newDonationsCount - currentDonationsCount,
        "myDonationsCount should increase by 1"
      );
    });
    it("includes donation in myDonation", async () => {
      await fundraiser.donate({ from: donor, value });
      const { values, dates } = await fundraiser.myDonations({
        from: donor,
      });
      assert.equal(value, values[0], "values should match");
      assert(dates[0], "date should be present");
    });
    it("increase the totalDonations amount", async () => {
      const currentTotalDonations = await fundraiser.totalDonations();
      await fundraiser.donate({ from: donor, value });
      const newTotalDonations = await fundraiser.totalDonations();

      // 寄付すると寄付額分だけ増加する！
      const diff = newTotalDonations - currentTotalDonations;
      assert.equal(diff, value, "difference should match the donations value");
    });
    // 寄付の件数のテスト
    it("increase donationsCount", async () => {
      const currentDonationsCount = await fundraiser.donationsCount();
      await fundraiser.donate({ form: donor, value });
      const newDonationsCount = await fundraiser.donationsCount();

      assert.equal(
        1,
        newDonationsCount - currentDonationsCount,
        "donationsCount should increase by 1"
      );
    });
    // イベントが発行されているかどうかのテスト
    it("emits the DonationReceived event", async () => {
      const tx = await fundraiser.donate({ from: donor, value });
      const expectedEvent = "DonationReceived";
      const actualEvent = tx.logs[0].event;

      assert.equal(actualEvent, expectedEvent, "events should match");
    });
  });
  describe("withdrawing funds", () => {
    beforeEach(async () => {
      await fundraiser.donate({
        from: accounts[2],
        value: web3.utils.toWei("0.1"),
      });
    });
  });
  describe("access controls", async () => {
    it("thrown an error when called from a non-owner account", async () => {
      try {
        await fundraiser.withdraw({ from: accounts[3] });
        assert.fail("withdraw was not restricted to owners");
      } catch (err) {
        const expectedError = "Ownable: caller is not the owner";
        const actualError = err.reason;
        assert.equal(actualError, expectedError, "should not be permitted");
      }
    });
    it("permits the owner to call the function", async () => {
      try {
        await fundraiser.withdraw({ from: owner });
        assert(true, "no errors were thrown");
      } catch (err) {
        assert.fail("should not have thrown an error");
      }
    });
    // contract の残高を受取人に送金するテスト
    it("transfers balance to beneficiary", async () => {
      // getBalanceで残高にアクセス。
      const currentContractBalance = await web3.eth.getBalance(
        fundraiser.address
      );
      const currentBeneficiaryBalance = await web3.eth.getBalance(beneficiary);

      await fundraiser.withdraw({ from: owner });

      const newContractBalance = await web3.eth.getBalance(fundraiser.address);
      const newBeneficiaryBalance = await web3.eth.getBalance(beneficiary);
      const beneficiaryDifference =
        newBeneficiaryBalance - currentBeneficiaryBalance;

      assert.equal(newContractBalance, 0, "contract should have a 0 balance");

      assert.equal(
        beneficiaryDifference,
        currentContractBalance,
        "beneficiary should receive all the funds"
      );
    });
    it("emits Withdraw event", async () => {
      const tx = await fundraiser.withdraw({ from: owner });
      const expectedEvent = "Withdraw";
      const actualEvent = tx.logs[0].event;

      assert.equal(actualEvent, expectedEvent, "events should match");
    });
  });
  // フォールバック関数
  describe("fallback function", () => {
    const value = web3.utils.toWei("0.0289");

    it("increase the totalDonations amount", async () => {
      const currentTotalDonations = await fundraiser.totalDonations();
      await web3.eth.sendTransaction({
        to: fundraiser.address,
        from: accounts[9],
        value,
      });
      const newTotalDonations = await fundraiser.totalDonations();
      const diff = newTotalDonations - currentTotalDonations;

      assert.equal(diff, value, "difference should match the donation value");
    });
    it("increase donationsCount", async () => {
      const currentDonationsCount = await fundraiser.donationsCount();
      // sendTransaction .. fallback funcが使える！
      await web3.eth.sendTransaction({
        to: fundraiser.address,
        from: accounts[9],
        value,
      });
      const newDonationsCount = await fundraiser.donationsCount();

      assert.equal(
        1,
        newDonationsCount - currentDonationsCount,
        "donationsCount should increment by 1"
      );
    });
  });
});
