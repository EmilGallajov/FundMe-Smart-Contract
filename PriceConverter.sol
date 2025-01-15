// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice() internal view returns (uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF);
        (,int256 price,,,) = priceFeed.latestRoundData();
        return uint256(price * 1e10); //The price returned by Chainlink is in 8 decimals (e.g., 1500.12345678 USD).
        //To convert it to 18 decimals (to match Ethereum's wei standard), multiply by 10101010.
    }
    
    function getConversionRate(uint256 ethAmount) internal view returns (uint256)  {
            uint256 ethPrice = getPrice();
            uint256 ethAmountInUsd =(ethPrice * ethAmount) / 1e10; // (2*10**18) * (1*10**18) / (2*10**18) = (2*10**18)USD
            return ethAmountInUsd;
    }

    function getVersion() internal view returns(uint256) {
        // Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version(); 
    } 
}
