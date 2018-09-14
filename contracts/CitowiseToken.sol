pragma solidity ^0.4.24;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Mintable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Capped.sol";
import "./ERC20Burnable.sol";


/**
 * @title Basic token
 * @dev Basic version of StandardToken, with no allowances.
 */
contract CitowiseToken is ERC20, Ownable, ERC20Mintable, ERC20Burnable, ERC20Capped {

    string public name;
    string public symbol;
    uint8 public decimals;

    uint256 constant public TOKENS_CAP = 500000000;
    uint256 constant public ETHER = 1000000000000000000;

    constructor() public ERC20Capped(TOKENS_CAP * ETHER) {
        name = "Citowise Token";
        symbol = "CTW";
        decimals = 18;
    }

    function burn(address _who, uint256 _value) public onlyOwner() onlyBeforeMintingFinished() {
        _burn(_who, _value);
    }

}
