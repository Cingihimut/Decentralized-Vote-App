// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Migrations {
  address owner = msg.sender;
  uint256 lastCompiltedMigration;

  constructor() payable {
    owner = msg.sender;
  }

  modifier restricted() {
    require(
      msg.sender == owner,
      "This function is restricted to the contract's owner"
    );
    _;
  }

  function setCompleted(uint completed) public restricted {
    lastCompiltedMigration = completed;
  }

  function upgrade (address _newAddress) external restricted {
    Migrations upgraded = Migrations(_newAddress);
    upgraded.setCompleted(lastCompiltedMigration);
  }
}
