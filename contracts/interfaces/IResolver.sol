pragma solidity <=0.5.4;

interface IResolver {
    function getAddress(bytes32 name) external view returns (address);

    function getAsset(bytes32 assetType, bytes32 assetName) external view returns (bool, address);

    function getAssets(bytes32 assetType) external view returns (bytes32[] memory);

    event AssetChanged(bytes32 indexed assetType, bytes32 indexed assetName, address previousValue, address newValue);
    event AddressChanged(bytes32 indexed name, address indexed previousValue, address indexed newValue);
    event SynbitTokenMigrated(bytes32 indexed name, address indexed previousValue, address indexed newValue);
}
