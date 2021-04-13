pragma solidity ^0.5.17;

import '../lib/PreciseMath.sol';

contract MockPreciseMath {
    using PreciseMath for uint256;

    function max(uint256 a, uint256 b) external pure returns (uint256) {
        return a.max(b);
    }

    function min(uint256 a, uint256 b) external pure returns (uint256) {
        return a.min(b);
    }

    function decimalsTo(
        uint256 a,
        uint256 b,
        uint256 c
    ) external pure returns (uint256) {
        return a.decimalsTo(b, c);
    }

    function toDecimal(uint256 a) external pure returns (uint256) {
        return a.toDecimal();
    }

    function toPrecise(uint256 a) external pure returns (uint256) {
        return a.toPrecise();
    }

    function decimalMultiply(uint256 a, uint256 b) external pure returns (uint256) {
        return a.decimalMultiply(b);
    }

    function decimalDivide(uint256 a, uint256 b) external pure returns (uint256) {
        return a.decimalDivide(b);
    }

    function preciseMultiply(uint256 a, uint256 b) external pure returns (uint256) {
        return a.preciseMultiply(b);
    }

    function preciseDivide(uint256 a, uint256 b) external pure returns (uint256) {
        return a.preciseMultiply(b);
    }
}
