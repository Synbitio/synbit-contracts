pragma solidity <=0.5.4;

import './storages/AddressStorage.sol';
import './interfaces/IOracle.sol';
import './interfaces/IAssetPrice.sol';

contract AssetPrice is AddressStorage, IAssetPrice {
    constructor() public {
        setContractName(CONTRACT_ASSET_PRICE);
    }

    function setOracle(bytes32 asset, address oracle) external onlyOwner {
        emit OracleChanged(asset, getAddressValue(asset), oracle);
        setAddressValue(asset, oracle);
    }

    function removeOracle(bytes32 asset) external onlyOwner {
        emit OracleRemoved(asset, getAddressValue(asset));
        removeAddressValue(asset);
    }

    function getPriceFromOracle(bytes32 asset)
        public
        view
        returns (
            uint256 round,
            uint256 price,
            uint256 time
        )
    {
        address oracleAddress = getAddressValue(asset);
        string memory errorMessage = 'AssetPrice';
        require(oracleAddress != address(0), errorMessage.concat(': Missing Oracle For ', asset));
        (round, price, time) = IOracle(oracleAddress).getPrice(asset);
    }

    function getPrice(bytes32 asset) public view returns (uint256) {
        (uint256 price, ) = getPriceAndStatus(asset);
        return price;
    }

    function getPrices(bytes32[] memory assets) public view returns (uint256[] memory) {
        (uint256[] memory prices, ) = getPricesAndStatus(assets);
        return prices;
    }

    function getPriceAndStatus(bytes32 asset) public view returns (uint256, uint256) {
        if (asset == USD || asset == 'USDT') return (1 ether, 0);
        (, uint256 price, uint256 updateTime) = getPriceFromOracle(asset);
        require(price > 0, contractName.concat(': Price is zero For ', asset));

        uint256 lastTime = now - 3600;
        if (updateTime < lastTime) return (price, 1);
        return (price, 0);
    }

    function getPricesAndStatus(bytes32[] memory assets) public view returns (uint256[] memory, uint256[] memory) {
        require(assets.length < 20, contractName.concat(': cannot have more than 20 items'));

        uint256[] memory prices = new uint256[](assets.length);
        uint256[] memory status = new uint256[](assets.length);
        for (uint256 i = 0; i < assets.length; i++) {
            (prices[i], status[i]) = getPriceAndStatus(assets[i]);
        }
        return (prices, status);
    }
}
