pragma solidity <=0.5.4;

contract MockSetting {
    function getMinStakeTime() external pure returns (uint256) {
        return 5 seconds;
    }

    function getCollateralRate(bytes32) external pure returns (uint256) {
        return 2 ether;
    }

    function getTradingFeeRate(bytes32) external pure returns (uint256) {
        return 0.003 ether;
    }
}
