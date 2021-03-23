pragma solidity <=0.5.4;

import './lib/SafeERC20.sol';
import './base/Rewards.sol';
import './interfaces/ITrader.sol';
import './interfaces/storages/ITraderStorage.sol';
import './interfaces/IIssuer.sol';
import './interfaces/ISetting.sol';
import './interfaces/IAssetPrice.sol';
import './interfaces/IERC20.sol';

contract Trader is Rewards, ITrader {
    using SafeERC20 for IERC20;

    address public constant FEE_ADDRESS = 0x0FeefeefeEFeeFeefeEFEEFEEfEeFEeFeeFeEfEe;

    constructor(IResolver _resolver) public Importable(_resolver) {
        setContractName(CONTRACT_TRADER);
        imports = [
            CONTRACT_SYNBIT,
            CONTRACT_SUPPLY_SCHEDULE,
            CONTRACT_ISSUER,
            CONTRACT_SETTING,
            CONTRACT_ASSET_PRICE,
            CONTRACT_SYNBIT_TOKEN
        ];
    }

    function Storage() private view returns (ITraderStorage) {
        return ITraderStorage(getStorage());
    }

    function Issuer() private view returns (IIssuer) {
        return IIssuer(requireAddress(CONTRACT_ISSUER));
    }

    function Setting() private view returns (ISetting) {
        return ISetting(requireAddress(CONTRACT_SETTING));
    }

    function AssetPrice() private view returns (IAssetPrice) {
        return IAssetPrice(requireAddress(CONTRACT_ASSET_PRICE));
    }

    function trade(
        address account,
        bytes32 fromSynth,
        uint256 fromAmount,
        bytes32 toSynth
    )
        external
        onlyAddress(CONTRACT_SYNBIT)
        returns (
            uint256 tradingAmount,
            uint256 tradingFee,
            uint256 fromSynthPrice,
            uint256 toSynthPirce
        )
    {
        (tradingAmount, tradingFee, fromSynthPrice, toSynthPirce) = getTradingAmountAndFee(
            fromSynth,
            fromAmount,
            toSynth
        );

        Issuer().burnSynth(fromSynth, account, fromAmount);
        Issuer().issueSynth(toSynth, account, tradingAmount);
        Issuer().issueSynth(USD, FEE_ADDRESS, tradingFee);

        Storage().incrementTradingFee(account, getCurrentPeriod(), tradingFee);
    }

    function getTradingAmountAndFee(
        bytes32 fromSynth,
        uint256 fromAmount,
        bytes32 toSynth
    )
        public
        view
        returns (
            uint256 tradingAmount,
            uint256 tradingFee,
            uint256 fromSynthPrice,
            uint256 toSynthPirce
        )
    {
        fromSynthPrice = AssetPrice().getPrice(fromSynth);
        toSynthPirce = AssetPrice().getPrice(toSynth);

        uint256 fromSynthValue = fromAmount.decimalMultiply(fromSynthPrice);
        tradingFee = fromSynthValue.decimalMultiply(Setting().getTradingFeeRate(toSynth));
        tradingAmount = fromSynthValue.sub(tradingFee).decimalDivide(toSynthPirce);
    }

    function getTradingAmountAndFee(
        bytes32 fromSynth,
        bytes32 toSynth,
        uint256 toAmount
    )
        public
        view
        returns (
            uint256 tradingAmount,
            uint256 tradingFee,
            uint256 fromSynthPrice,
            uint256 toSynthPirce
        )
    {
        fromSynthPrice = AssetPrice().getPrice(fromSynth);
        toSynthPirce = AssetPrice().getPrice(toSynth);

        uint256 toSynthValue = toAmount.decimalMultiply(toSynthPirce);
        uint256 tradingFeeRate = Setting().getTradingFeeRate(toSynth);
        uint256 fromSynthValue = toSynthValue.decimalDivide(PreciseMath.DECIMAL_ONE().sub(tradingFeeRate));
        tradingFee = fromSynthValue.decimalMultiply(tradingFeeRate);
        tradingAmount = fromSynthValue.decimalDivide(fromSynthPrice);
    }

    function claim(bytes32 asset, address account)
        external
        onlyAddress(CONTRACT_SYNBIT)
        returns (
            uint256 period,
            uint256 amount,
            uint256 vestTime
        )
    {
        uint256 claimable = getClaimable(asset, account);
        require(claimable > 0, 'Trader: claimable is zero');

        uint256 claimablePeriod = getClaimablePeriod();
        setClaimed(asset, account, claimablePeriod, claimable);

        IERC20(requireAddress(CONTRACT_SYNBIT_TOKEN)).safeTransfer(account, claimable);

        return (claimablePeriod, claimable, 0);
    }

    function getClaimable(bytes32 asset, address account) public view returns (uint256) {
        require(asset == SYN, 'Trader: only supports SYN');

        uint256 rewards = getRewardSupply(CONTRACT_TRADER);
        if (rewards == 0) return 0;

        uint256 claimablePeriod = getClaimablePeriod();
        if (getClaimed(asset, account, claimablePeriod) > 0) return 0;

        uint256 totalTradingFee = Storage().getTradingFee(address(0), claimablePeriod);
        uint256 accountTradingFee = Storage().getTradingFee(account, claimablePeriod);
        uint256 percentage = accountTradingFee.decimalDivide(totalTradingFee);
        return rewards.decimalMultiply(percentage);
    }

    function getTradingFee(uint256 period) external view returns (uint256) {
        return Storage().getTradingFee(address(0), period);
    }
}
