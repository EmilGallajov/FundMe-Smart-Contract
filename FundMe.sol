// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;
    // using constant leads to gas efficiency
    uint256 public constant MINIMUM_USD = 5e18; 
    address[] public funders;
    mapping (address funder => uint256 amountFunded) public addressToAmountFunded;
    address public immutable i_owner; // it helps to make immutable and gas efficient 
    //with immutable: 439 gas
    //without immutable: 2574 gas

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        require(msg.value.getConversionRate() >= MINIMUM_USD, "did not send enough ETH!"); // it means 10**18 or 1 ETH   
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value; 
    }

    function withdraw() public onlyOwner {
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0; 
        }
        funders = new address[](0);
        // // transfer
        // payable(msg.sender.transfer(address(this).balance));
        // // send
        // bool sendSuccess = msg.sender.send(address(this).balance);
        // require(sendSuccess, "Send Failed!");
        // call
        (bool calSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(calSuccess, "Call Failed!");
        revert();
    }

    modifier onlyOwner() {
    // _; if this mark becomes like that it means you should this modifier will be executed after function withdraw() execution
    // require(msg.sender == i_owner, "you cannot withdraw if you are not the owner");
    if (msg.sender != i_owner) {revert NotOwner();}
    _; // it means that we run the code inside of this function after the end check and before executing
    }   

    receive() external payable { 
        fund();
    }
    fallback() external payable {
        fund();
    }

}
