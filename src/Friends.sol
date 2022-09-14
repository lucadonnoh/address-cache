// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./AddressCache.sol";

contract Friends is AddressCache {
    mapping(address => address[]) public friends;

    function addFriend(address _friend) public {
        friends[msg.sender].push(_friend);
        cacheWrite(_friend);
    }

    function addFriendWithCache(uint32 _friendKey) public {
        friends[msg.sender].push(cacheRead(_friendKey));
    }

    function getFriends() public view returns (address[] memory) {
        return friends[msg.sender];
    }
}