pragma solidity <=0.5.4;

contract MockIssuer {
    uint256 private _debtPercentage = 0.3 ether * 10**9;

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
        return 10 * 1e27;
    }

    function getDebtPercentage(
        bytes32 stake,
        address,
        uint256 period
    ) external view returns (uint256) {
        if (period == 1 || period == 4) return 0;
        if (stake == 'ETH') return 0;
        return _debtPercentage;
    }

    function setDebtPercentage(uint256 debtPercentage) external {
        _debtPercentage = debtPercentage;
    }
}
