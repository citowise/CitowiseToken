pragma solidity ^0.4.24;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol";
import "openzeppelin-solidity/contracts/token/ERC20/CappedToken.sol";
import "openzeppelin-solidity/contracts/token/ERC20/BurnableToken.sol";


/**
 * @title Basic token
 * @dev Basic version of StandardToken, with no allowances.
 */
contract CitowiseToken is StandardToken, Ownable, CappedToken, BurnableToken {

    string public name;
    string public symbol;
    uint8 public decimals;

    constructor() public CappedToken(500000000) {
        name = "Citowise Token";
        symbol = "CTW";
        decimals = 18;
    }
}