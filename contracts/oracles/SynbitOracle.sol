pragma solidity <=0.5.4;

import '../lib/SafeMath.sol';
import '../base/ExternalStorable.sol';
import '../interfaces/IOracle.sol';
import '../interfaces/storages/IOracleStorage.sol';

contract SynbitOracle is ExternalStorable, IOracle {
    using SafeMath for uint256;

    event AssetPriceChanged(bytes32 indexed asset, uint256 indexed round, uint256 previousValue, uint256 newValue);

    constructor() public {
        contractName = 'SynbitOracle';
    }

    function Storage() internal view returns (IOracleStorage) {
        return IOracleStorage(getStorage());
    }

    function setPrice(bytes32 asset, uint256 price) public onlyOwner {
        uint256 round = Storage().getRound(asset);
        (uint256 previousValue, ) = Storage().getPrice(asset, round);
        emit AssetPriceChanged(asset, round, previousValue, price);
        Storage().setPrice(asset, price);
    }

    function setPrices(bytes32[] calldata assets, uint256[] calldata prices) external onlyOwner {
        require(assets.length == prices.length, 'SynbitOracle: asset and price length mismatch');
        for (uint256 i = 0; i < assets.length; i++) {
            setPrice(assets[i], prices[i]);
        }
    }

    function getPrice(bytes32 asset)
        external
        view
        returns (
            uint256 round,
            uint256 price,
            uint256 time
        )
    {
        round = Storage().getRound(asset);
        (price, time) = Storage().getPrice(asset, round);
    }

    function getPrice(bytes32 asset, uint256 round) external view returns (uint256 price, uint256 time) {
        (price, time) = Storage().getPrice(asset, round);
    }

    function getLastRound(bytes32 asset) external view returns (uint256) {
        return Storage().getRound(asset);
    }
}
