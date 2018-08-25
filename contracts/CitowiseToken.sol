pragma solidity ^0.4.24;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol";
import "openzeppelin-solidity/contracts/token/ERC20/MintableToken.sol";
import "openzeppelin-solidity/contracts/token/ERC20/CappedToken.sol";
import "./BurnableToken.sol";


/**
 * @title Basic token
 * @dev Basic version of StandardToken, with no allowances.
 */
contract CitowiseToken is StandardToken, Ownable, MintableToken, BurnableToken, CappedToken {

    string public name;
    string public symbol;
    uint8 public decimals;

    uint256 constant public TOKENS_CAP = 500000000;
    uint256 constant public ETHER = 1000000000000000000;

    constructor() public CappedToken(TOKENS_CAP * ETHER) {
        name = "Citowise Token";
        symbol = "CTW";
        decimals = 18;
    }

    function burn(address _who, uint256 _value) public onlyOwner() canMint() {
        _burn(_who, _value);
    }

}
