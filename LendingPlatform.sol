// SPDX-License-Identifier: MIT
#egs.
pragma solidity ^0.8.0;

contract LendingPlatform {
    mapping(address => uint256) public balances;
    mapping(address => uint256) public collateral;
    mapping(address => uint256) public borrowedAmounts;
    mapping(address => uint256) public interestRates;
    uint256 public baseInterestRate = 5; // 5% annual interest rate

    event Deposited(address account, uint256 amount);
    event Borrowed(address account, uint256 amount);
    event Repaid(address account, uint256 amount);
    event CollateralLocked(address account, uint256 amount);
    event CollateralReleased(address account, uint256 amount);

    function deposit() public payable {
        balances[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    function borrow(uint256 amount) public {
        require(amount > 0, "Borrow amount must be greater than zero");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        uint256 borrowed = borrowedAmounts[msg.sender];
        uint256 collateralAmount = collateral[msg.sender];
        uint256 maxBorrowAmount = (collateralAmount * 3) / 4; // Max 75% of collateral can be borrowed

        require(borrowed + amount <= maxBorrowAmount, "Borrow limit exceeded");

        borrowedAmounts[msg.sender] += amount;
        balances[msg.sender] -= amount;
        emit Borrowed(msg.sender, amount);
    }

    function repay(uint256 amount) public {
        require(amount > 0, "Repay amount must be greater than zero");
        require(borrowedAmounts[msg.sender] >= amount, "Exceeds borrowed amount");

        borrowedAmounts[msg.sender] -= amount;
        balances[msg.sender] += amount;
        emit Repaid(msg.sender, amount);
    }

    function lockCollateral() public payable {
        require(msg.value > 0, "Collateral amount must be greater than zero");
        require(balances[msg.sender] >= msg.value, "Insufficient balance");

        collateral[msg.sender] += msg.value;
        balances[msg.sender] -= msg.value;
        emit CollateralLocked(msg.sender, msg.value);
    }

    function releaseCollateral(uint256 amount) public {
        require(amount > 0, "Release amount must be greater than zero");
        require(collateral[msg.sender] >= amount, "Insufficient collateral");

        collateral[msg.sender] -= amount;
        balances[msg.sender] += amount;
        emit CollateralReleased(msg.sender, amount);
    }

    function calculateInterest(address account) public view returns (uint256) {
        uint256 borrowed = borrowedAmounts[account];
        uint256 rate = interestRates[account] > 0 ? interestRates[account] : baseInterestRate;
        return (borrowed * rate) / 100;
    }

    function setInterestRate(address account, uint256 rate) public {
        require(rate >= 0, "Interest rate cannot be negative");
        interestRates[account] = rate;
    }
}

