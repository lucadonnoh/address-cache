// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Friends.sol";

contract FriendsTest is Test {
    Friends public friendsContract;
    function setUp() public {
       friendsContract = new Friends();
    }

    function testAddFriend(address _friend) public {
        friendsContract.addFriend(_friend);
        assertEq(friendsContract.getFriends()[0], _friend);

        vm.expectRevert("AddressCache: address already cached");
        friendsContract.addFriend(_friend);
    }

    function testAddFriendWithCache(uint32 _friendKey) public {
        vm.expectRevert("AddressCache: key not found");
        friendsContract.addFriendWithCache(_friendKey);

        friendsContract.addFriend(address(0xD00D));

        vm.prank(address(0xB0B));
        friendsContract.addFriendWithCache(1);
        assertEq(friendsContract.getFriends()[0], address(0xD00D));
    }

}
