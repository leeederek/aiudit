// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "truffle/Assert.sol";
import "../contracts/DNDToken.sol";

contract TestDNDToken {
    DNDToken dndToken;

    function beforeEach() public {
        dndToken = new DNDToken();
    }

    function testInitialBalance() public {
        uint256 expected = 1000000000000000000000000000;
        Assert.equal(dndToken.balanceOf(msg.sender), expected, "Initial balance should be 1,000,000,000 DND");
    }

    function testTransfer() public {
        uint256 amount = 1000000000000000000;
        address recipient = 0x1234567890123456789012345678901234567890;
        dndToken.transfer(recipient, amount);
        Assert.equal(dndToken.balanceOf(recipient), amount, "Recipient should have received 1 DND");
    }

    function testApprove() public {
        uint256 amount = 1000000000000000000;
        address spender = 0x1234567890123456789012345678901234567890;
        dndToken.approve(spender, amount);
        Assert.equal(dndToken.allowance(msg.sender, spender), amount, "Spender should be approved to spend 1 DND");
    }

    function testTransferFrom() public {
        uint256 amount = 1000000000000000000;
        address recipient = 0x1234567890123456789012345678901234567890;
        address spender = 0x0987654321098765432109876543210987654321;
        dndToken.approve(spender, amount);
        dndToken.transferFrom(msg.sender, recipient, amount, {from: spender});
        Assert.equal(dndToken.balanceOf(recipient), amount, "Recipient should have received 1 DND");
        Assert.equal(dndToken.allowance(msg.sender, spender), 0, "Spender should no longer be approved to spend DND");
    }
}