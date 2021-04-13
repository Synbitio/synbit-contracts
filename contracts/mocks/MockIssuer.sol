pragma solidity ^0.5.17;

contract MockIssuer {
    uint256 private _debtPercentage = 0.3 ether * 10**9;

    mapping(address => uint256) _rate;

    function issueSynth(
        bytes32,
        address,
        uint256
    ) external {}

    function burnSynth(
        bytes32,
        address,
        uint256
    ) external {}

    function getDebt(bytes32, address) external pure returns (uint256) {
        return 10 * 1e18;
    }

    function getDebtPercentage(
        bytes32 stake,
        address account,
        uint256 period
    ) external view returns (uint256) {
        if (period == 1 || period == 4) return 0;
        if (stake == 'ETH') return 0;
        return _rate[account];
    }

    function setDebtPercentage(address account, uint256 rate) external {
        _rate[account] = rate;
    }
}
