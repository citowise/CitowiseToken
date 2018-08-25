// /*global contract, config, it, assert*/
const { assertRevert } = require('./helpers/assertRevert');
const CitowiseToken = artifacts.require("CitowiseToken");

contract("CitowiseToken", accounts => {

  beforeEach(async function () {
    this.owner = accounts[0];
    this.token = await CitowiseToken.new({ from: this.owner });
  });

  describe('creation', function() {
    it('has a creator assigned', async function () {
      const creator = await this.token.owner();

      assert.equal(creator, this.owner, "wasn't in the first account");
    })
  });

  describe('minting', function() {
    it('allows creater to mint', async function () {
      const result = await this.token.mint(
        "0x0123456789012345678901234567890123456789",
        "100000000000000000000000",
        { from: this.owner }
      );

      assert.equal(result.receipt.status, true);
    });

    it('does not allow user to mint', async function () {
      const unallowedMinter = accounts[1];

      await assertRevert(this.token.mint(
        "0x0123456789012345678901234567890123456789",
        "100000000000000000000000",
        { from: unallowedMinter }
      ));
    });

    describe('in finished', function() {
      beforeEach(async function () {
        await this.token.finishMinting({ from: this.owner });
      });

      it('does not allow creator to mint', async function () {
        await assertRevert(this.token.mint(
          "0x0123456789012345678901234567890123456789",
          "100000000000000000000000",
          { from: this.owner }
        ));
      })
    });
  });

  describe('burning', function() {
    beforeEach(async function () {
      await this.token.mint(
        "0x0123456789012345678901234567890123456789",
        "220",
        { from: this.owner }
      );
    });

    it('allows creater to burn', async function () {
      const result = await this.token.burn(
        "0x0123456789012345678901234567890123456789",
        "100",
        { from: this.owner }
      );

      assert.equal(result.receipt.status, true);
    });

    it('does not allow creater to burn if insufficient balance', async function () {
      await assertRevert(this.token.burn(
        "0x0123456789012345678901234567890123456789",
        "1000",
        { from: this.owner }
      ));
    });

    it('does not allow user to burn', async function () {
      const unallowedBurner = accounts[1];

      await assertRevert(this.token.burn(
        "0x0123456789012345678901234567890123456789",
        "100",
        { from: unallowedBurner }
      ));
    });

    describe('minting in finished', function() {
      beforeEach(async function () {
        await this.token.finishMinting({ from: this.owner });
      });

      it('does not allow creator to burn', async function () {
        await assertRevert(this.token.mint(
          "0x0123456789012345678901234567890123456789",
          "100",
          { from: this.owner }
        ));
      })
    });
  });

});
