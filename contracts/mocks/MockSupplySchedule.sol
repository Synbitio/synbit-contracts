pragma solidity <=0.5.4;

contract MockSupplySchedule {
    uint256 public nextMintTime;
    uint256 public currentPeriod = 2;
    uint256 private _mintableSupply = 10 ether;

    constructor(uint256 _nextMintTime) public {
        nextMintTime = _nextMintTime;
    }

    function lastMintTime() external view returns (uint256) {
        return nextMintTime;
    }

    function setCurrentPeriod(uint256 _currentPeriod) external {
        currentPeriod = _currentPeriod;
    }

    function distributeSupply() external pure returns (address[] memory recipients, uint256[] memory amounts) {
        recipients = new address[](1);
        recipients[0] = address(0);

        amounts = new uint256[](1);
        amounts[0] = 10 ether;
    }

    function mintableSupply(bytes32, uint256) external view returns (uint256) {
        return _mintableSupply;
    }

    function setMintableSupply(uint256 value) external {
        _mintableSupply = value;
    }
}
