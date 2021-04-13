pragma solidity ^0.5.17;

contract MockAssetPrice {
    function getPrice(bytes32 asset) public pure returns (uint256) {
        return (asset == 'yETH') ? 1500 ether : 1 ether;
    }

    function getPrices(bytes32[] calldata asset) external pure returns (uint256[] memory) {
        uint256[] memory prices = new uint256[](asset.length);
        for (uint256 i = 0; i < asset.length; i++) {
            prices[i] = getPrice(asset[0]);
        }
        return prices;
    }
}
