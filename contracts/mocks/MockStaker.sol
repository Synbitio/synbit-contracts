pragma solidity ^0.5.17;

contract MockStaker {
    mapping(address => uint256) _rate;

    function getCollateralRate(bytes32, address account) external view returns (uint256) {
        return _rate[account];
    }

    function setCollateralRate(address account, uint256 rate) external {
        _rate[account] = rate;
    }
}
