pragma solidity <=0.5.4;

contract MockSynbitToken {
    mapping(address => uint256) _locked;

    function lock(address account, uint256 amount) external returns (bool) {
        _locked[account] += amount;
        _locked[address(0)] += amount;
        return true;
    }

    function unlock(address account, uint256 amount) external returns (bool) {
        require(_locked[account] >= amount, 'MockSynbitToken: unlock amount exceeds locked');

        _locked[account] -= amount;
        _locked[address(0)] -= amount;
        return true;
    }

    function getLocked(address account) external view returns (uint256) {
        return _locked[account];
    }

    function getTotalLocked() external view returns (uint256) {
        return _locked[address(0)];
    }

    function transfer(address, uint256) external pure returns (bool) {
        return true;
    }

    function migrate(address, address) external pure returns (bool) {
        return true;
    }
}
