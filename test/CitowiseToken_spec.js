// /*global contract, config, it, assert*/
const CitowiseToken = artifacts.require("CitowiseToken");

contract("CitowiseToken", accounts => {

  it('has a creator assigned', async function () {
    const owner = accounts[0]
    const citowiseToken = await CitowiseToken.new({ from: owner })
    const creator = await citowiseToken.owner()

    assert.equal(creator, owner, "wasn't in the first account")
  })
})
