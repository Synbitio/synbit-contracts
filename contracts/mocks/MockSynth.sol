pragma solidity <=0.5.4;

contract MockSynth {
    uint256 public totalSupply;

    mapping(address => uint256) _locked;

    function lock(address account, uint256 amount) external returns (bool) {
        _locked[account] += amount;
        _locked[address(0)] += amount;
        return true;
    }

    function unlock(address account, uint256 amount) external returns (bool) {
        require(_locked[account] >= amount, 'MockSynth: unlock amount exceeds locked');

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

    function mint(address, uint256 amount) external returns (bool) {
        totalSupply += amount;
        return true;
    }

    function burn(address, uint256 amount) external returns (bool) {
        require(totalSupply >= amount, 'MockSynth: burn amount exceeds balance');
        totalSupply -= amount;
        return true;
    }
}
