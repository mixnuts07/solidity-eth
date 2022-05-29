// contractをデプロイできるかのテスト

// truffle ではartifacts.requireでコンパイル済みのコントラクトを読み込み操作できる！
const GreeterContract = artifacts.require("Greeter");
// truffle のテストでは　Mocha を使う！
// contract　は全く新しいcontractを作成　→ テストグループ間で状態の共有を防ぐ！
contract("Greeter", (accounts) => {
  // チェーンとのやりとりは全て非同期！！
  it("has been deployed successfully", async () => {
    const greeter = await GreeterContract.deployed();
    assert(greeter, "contract was not deployed");
  });

  describe("greet()", () => {
    it("returns 'Hello, World!'", async () => {
      const greeter = await GreeterContract.deployed();
      const expected = "Hello, World!";
      const actual = await greeter.greet();
      assert.equal(actual, expected, "greeted with 'Hello, World!'");
    });
  });
  describe("owner()", () => {
    it("returns the address of the owner", async () => {
      const greeter = await GreeterContract.deployed();
      const owner = await greeter.owner();
      assert(owner, "the current owner");
    });
    it("matches the address that originally deployed the contract", async () => {
      const greeter = await GreeterContract.deployed();
      const owner = await greeter.owner();
      const expected = accounts[0];
      assert(owner, expected, "matches address used to deploy contract");
    });
  });
});

contract("Greeter : update greeting", (accounts) => {
  describe("setGreeting(string)", () => {
    describe("when message is sent by the owner", () => {
      it("sets greeting to passed in string", async () => {
        const greeter = await GreeterContract.deployed();
        const expected = "The owner changed the message";

        await greeter.setGreeting(expected);
        const actual = await greeter.greet();

        assert.equal(actual, expected, "greeting was not updated");
      });
    });
    describe("when message is sent by another account", () => {
      it("it does not set the greeting", async () => {
        const greeter = await GreeterContract.deployed();
        const expected = await greeter.greet();
        try {
          await greeter.setGreeting("Not the owner", { from: accounts[0] });
        } catch (err) {
          const errorMessage = "Ownable : caller is not the owner";
          assert.equal(err.reason, errorMessage, "greeting should not updated");
          return;
        }
        assert(false, "greeting should not update");
      });
    });
  });
});
