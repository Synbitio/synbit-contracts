pragma solidity ^0.5.17;

import '../interfaces/ILockable.sol';

contract MockHolder {
    address public constant LOCK_ADDRESS = 0x010C10C10C10C10c10c10C10c10C10c10c10C10c;

    ILockable private _token;

    function setToken(ILockable token) external {
        _token = token;
    }

    function lock(address account, uint256 amount) external returns (bool) {
        return _token.lock(account, amount);
    }

    function unlock(address account, uint256 amount) external returns (bool) {
        return _token.unlock(account, amount);
    }
}
