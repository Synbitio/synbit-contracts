pragma solidity <=0.5.4;

interface IIssuer {
    function issueDebt(
        bytes32 stake,
        address account,
        uint256 amount
    ) external;

    function burnDebt(
        bytes32 stake,
        address account,
        uint256 amount
    ) external returns (uint256);

    function issueSynth(
        bytes32 synth,
        address account,
        uint256 amount
    ) external;

    function burnSynth(
        bytes32 synth,
        address account,
        uint256 amount
    ) external;

    function getDebt(bytes32 stake, address account) external view returns (uint256);

    function getTotalDebt() external view returns (uint256);

    function getDebtPercentage(
        bytes32 stake,
        address account,
        uint256 period
    ) external view returns (uint256);
}
