pragma solidity <=0.5.4;

contract MockEscrow {
    mapping(address => uint256) public deposits;

    function deposit(
        uint256,
        address account,
        uint256 amount
    ) external {
        deposits[account] = deposits[account] + amount;
    }

    function getStaked(address account) external view returns (uint256) {
        return deposits[account];
    }
}
