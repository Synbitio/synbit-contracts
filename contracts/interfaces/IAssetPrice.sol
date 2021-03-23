pragma solidity <=0.5.4;

interface IAssetPrice {
    function getPrice(bytes32 asset) external view returns (uint256);

    function getPrices(bytes32[] calldata assets) external view returns (uint256[] memory);

    event OracleChanged(bytes32 indexed asset, address indexed previousValue, address indexed newValue);
    event OracleRemoved(bytes32 indexed asset, address indexed previousValue);
}
