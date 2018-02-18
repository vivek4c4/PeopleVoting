pragma solidity ^0.4.17;

contract owned{
    address owner;
    function owned() public{
        owner=msg.sender;
    }
    modifier onlyowner{
        assert(msg.sender==owner);
        _;
    }
}