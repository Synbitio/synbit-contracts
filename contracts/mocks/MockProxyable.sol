pragma solidity <=0.5.4;

import '../lib/SafeERC20.sol';
import '../base/Proxyable.sol';
import '../interfaces/IERC20.sol';

contract MockProxyable is Proxyable {
    using SafeERC20 for IERC20;

    uint256 private _value;

    event FromAccount(address indexed account);
    event FromManager(address indexed account);
    event Deposited(address indexed sender, address indexed recipient, uint256 amount);
    event Withdrawn(address indexed sender, address indexed recipient, uint256 amount);

    function initialize(address _manager) external onlyOwner returns (bool) {
        setInitialized();
        setManager(_manager);
        setContractName('MockProxyable');
        return true;
    }

    function fromAccount() external onlyInitialized returns (bool) {
        emit FromAccount(msg.sender);
        return true;
    }

    function fromManager() external onlyInitialized onlyManager('Manager') returns (bool) {
        emit FromManager(msg.sender);
        return true;
    }

    function internalDeposit() internal returns (bool) {
        _value = 100;
        return true;
    }

    function depositETH() external payable onlyInitialized returns (bool) {
        emit Deposited(msg.sender, address(this), msg.value);
        return true;
    }

    function depositToken(address token, uint256 amount) external onlyInitialized returns (bool) {
        IERC20(token).transferFrom(msg.sender, address(this), amount);
        emit Deposited(msg.sender, address(this), amount);
        return true;
    }

    function withdrawETH(uint256 amount) external onlyInitialized returns (bool) {
        msg.sender.transfer(amount);
        emit Withdrawn(address(this), msg.sender, amount);
        return true;
    }

    function withdrawToken(address token, uint256 amount) external onlyInitialized returns (bool) {
        IERC20(token).transfer(msg.sender, amount);
        emit Withdrawn(address(this), msg.sender, amount);
        return true;
    }
}
