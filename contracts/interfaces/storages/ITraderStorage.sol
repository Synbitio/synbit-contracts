pragma solidity <=0.5.4;

interface ITraderStorage {
    function incrementTradingFee(
        address account,
        uint256 period,
        uint256 amount
    ) external returns (uint256);

    function getTradingFee(address account, uint256 period) external view returns (uint256);
}
