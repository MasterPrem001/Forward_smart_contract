// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract ETHForwardWithUSDC {
    address internal buyer;
    address internal seller;
    IERC20 public usdcToken;

    uint256 internal strikePrice; // in USDC (e.g., 2000 * 1e6)
    uint256 internal ethAmount;   // in wei(eg 1 ether = 1* 1e18)
    bool public isSettled;
    uint256 public settlementDate;
    bool public buyerRejected;
    bool public sellerRejected;

    constructor(
        address _buyer,
        address _seller,
        address _usdcToken,
        uint256 _strikePrice,
        uint256 _ethAmount_in_wei,
        uint256 _settlementDate
    ) {
        buyer = _buyer;
        seller = _seller;
        usdcToken = IERC20(_usdcToken);
        strikePrice = _strikePrice;
        ethAmount = _ethAmount_in_wei;
        settlementDate = _settlementDate;
    }

    function depositEther() external payable {
        require(msg.sender == seller, "Only seller can deposit");
        require(msg.value == ethAmount, "Incorrect ETH amount");
    }

    function executeForward() external {
        require(block.timestamp >= settlementDate, "Too early");
        require(msg.sender == buyer, "Only buyer can execute");
        require(!isSettled, "Already settled");

        isSettled = true;

        bool sent = usdcToken.transferFrom(buyer, seller, strikePrice);
        require(sent, "USDC transfer failed");

        payable(buyer).transfer(ethAmount);
    }
    function getContractDetails() public view returns (
    address _buyer,
    address _seller,
    uint256 _strikePrice,
    uint256 _ethAmount
) {
    return (buyer, seller, strikePrice, ethAmount);
}


function rejectContract() public {     // incase both want to cancel the contract
    require(block.timestamp < settlementDate, "Too late to reject");
    require(!isSettled, "Already settled");

    if (msg.sender == buyer) {
        buyerRejected = true;
    } else if (msg.sender == seller) {
        sellerRejected = true;
    } else {
        revert("Only buyer or seller can reject");
    }

    if (buyerRejected && sellerRejected) {
        isSettled = true;

        // Return ETH to seller
        payable(seller).transfer(ethAmount);
    }
}



    receive() external payable {}
}
