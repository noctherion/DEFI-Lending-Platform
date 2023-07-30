# DEFI Lending Platform

A lending application that allows users to lend or borrow cryptocurrency, with interest rates and collateral managed by smart contracts.

__Note:__ Please note that this implementation is for educational purposes only and should not be used in a production environment without further development and security audits.

__Explanation:__

The contract keeps track of user balances (balances), borrowed amounts (borrowedAmounts), collateral amounts (collateral), and user-specific interest rates (interestRates).

Users can deposit funds into their accounts using the deposit function.

Users can borrow funds against their collateral using the borrow function. The maximum amount that can be borrowed is limited to 75% of the user's collateral.

Users can repay borrowed amounts using the repay function.

Users can lock collateral using the lockCollateral function.

Users can release part of their collateral using the releaseCollateral function.

The calculateInterest function calculates the interest owed by a user based on their borrowed amount and interest rate. The interest rate is set per user using the setInterestRate function.
