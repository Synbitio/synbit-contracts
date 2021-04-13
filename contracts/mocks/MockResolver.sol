pragma solidity ^0.5.17;

import '../interfaces/ISynbitToken.sol';

contract MockResolver {
    address private _supplySchedule;
    address private _issuer;
    address private _holder;

    constructor(
        address supplySchedule,
        address issuer,
        address holder
    ) public {
        _supplySchedule = supplySchedule;
        _issuer = issuer;
        _holder = holder;
    }

    function getAddress(bytes32 name) external view returns (address) {
        if (name == 'Issuer') return _issuer;
        if (name == 'SupplySchedule') return _supplySchedule;
        if (name == 'Holder') return _holder;
    }

    function setHolder(address holder) external {
        _holder = holder;
    }

    function migrate(
        address token,
        address from,
        address to
    ) external {
        ISynbitToken(token).migrate(from, to);
    }
}
