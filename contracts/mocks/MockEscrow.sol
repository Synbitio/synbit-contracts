pragma solidity ^0.5.17;

contract MockEscrow {
    mapping(address => uint256) public deposits;

    function deposit(
        uint256,
        address account,
        uint256 amount
    ) external returns (uint256 vestTime) {
        deposits[account] = deposits[account] + amount;
        return 0;
    }

    function getStaked(address account) external view returns (uint256) {
        return deposits[account];
    }
}
