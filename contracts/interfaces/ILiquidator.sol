pragma solidity <=0.5.4;
pragma experimental ABIEncoderV2;

import '../lib/Paging.sol';

interface ILiquidator {
    function watchAccount(bytes32 stake, address account) external;

    function canLiquidate(bytes32 stake, address account) external view returns (bool);

    function getLiquidable(bytes32 stake, address account)
        external
        view
        returns (uint256 liquidable, uint256 unstakeAmount);

    function getAccounts(
        bytes32 stake,
        uint256 pageSize,
        uint256 pageNumber
    ) external view returns (address[] memory, Paging.Page memory);
}
