// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "forge-std/Script.sol";
import "../src/CrowdfundingCampaignV2.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";

// Part 1 of 2: Deploy the implementation contract. 
// Deploys the implementation contract and logs the address of the deployed implementation contract.
contract SuccessDeployTransparentProxyImplementation is Script {

    function run() public {
        vm.startBroadcast();
        
        CrowdfundingCampaignV2 crowdFundingImplementation = new CrowdfundingCampaignV2();
        console.log("Deployed CrowdfundingCampaignV2 implementation at:", address(crowdFundingImplementation));
 
        vm.stopBroadcast();
    }
 
}