// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract FallbackExample {
    uint256 public result;

    receive() external payable { 

    }
    fallback() external payable {
        result = 2;
     }
}
