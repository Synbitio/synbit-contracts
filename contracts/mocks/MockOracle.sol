pragma solidity ^0.5.17;

contract MockOracle {
    function getPrice(bytes32 asset)
        external
        view
        returns (
            uint256 round,
            uint256 price,
            uint256 time
        )
    {
        if (asset == 'ETH' || asset == 'yETH') return (0, 1000 ether, now);
        if (asset == 'SYN') return (0, 0.5 ether, now);
    }

    function getPrice(bytes32, uint256) external view returns (uint256 price, uint256 time) {
        return (0, now);
    }

    function getLastRound() external pure returns (uint256) {
        return 0;
    }
}
