pragma solidity ^0.4.18;

contract Sapphires {
  uint storedData;
  struct sapphire {
  			id = "";
  }

  sapphire[] public Sapphires;
  function set(uint x) public {
    storedData = x;
  }

  function get() public view returns (sapphire[] _list) {
    return Sapphires;
  }
}
