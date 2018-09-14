pragma solidity ^0.4.24;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";


/**
 * @title Burnable Token
 * @dev Token that can be irreversibly burned (destroyed).
 */
contract ERC20Burnable is ERC20, Ownable {

    event Burn(address indexed burner, uint256 value);

    /**
     * @dev Burns a specific amount of tokens. Allowed only for contract owner.
     * @param _value The amount of token to be burned.
     */
    function burn(address _who, uint256 _value) public onlyOwner() {
        _burn(_who, _value);
    }

    /**
     * @dev Overrides StandardToken._burn in order for burn and burnFrom to emit
     * an additional Burn event.
     */
    function _burn(address _who, uint256 _value) internal {
        super._burn(_who, _value);
        emit Burn(_who, _value);
    }
}
