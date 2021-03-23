pragma solidity <=0.5.4;

contract MockSynbitToken {
    mapping(address => uint256) _locked;

    function lock(address account, uint256 amount) external returns (bool) {
        _locked[account] += amount;
        return true;
    }

    function unlock(address account, uint256 amount) external returns (bool) {
        _locked[account] -= amount;
        return true;
    }

    function getLocked(address account) external view returns (uint256) {
        return _locked[account];
    }

    function transfer(address, uint256) external pure returns (bool) {
        return true;
    }

    function migrate(address, address) external pure returns (bool) {
        return true;
    }
}
