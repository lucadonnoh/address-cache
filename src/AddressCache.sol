// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// addresses are 20 bytes (160 bits) long
// uint32    are 4  bytes (32  bits) long which are    4294967296 possible values, around 4 billion
// uint40    are 5  bytes (40  bits) long which are 1099511627776 possible values, around 1 trillion

contract AddressCache {
    mapping(address => uint32) public address2key;
    address[] public key2address;

    function cacheWrite(address _address) internal returns (uint32) {
        require(key2address.length < type(uint32).max, "AddressCache: cache is full");
        require(address2key[_address] == 0, "AddressCache: address already cached");
        // keys must start from 1 because 0 means "not found"
        uint32 key = uint32(key2address.length + 1);
        address2key[_address] = key;
        key2address.push(_address);
        return key;
    }

    function cacheRead(uint32 _key) public view returns (address) {
        require(_key <= key2address.length && _key > 0, "AddressCache: key not found");
        return key2address[_key - 1];
    }
}