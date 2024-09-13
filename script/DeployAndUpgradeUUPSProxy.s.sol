// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "forge-std/Script.sol";
import {UUPSCrowdfundingCampaign} from "../src/UUPSCrowdfundingCampaign.sol";
import {V2_UUPSCrowdfundingCampaign} from "../src/V2_UUPSCrowdfundingCampaign.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";

contract DeployAndUpgradeUUPSProxy is Script {

    function run() public {
        // Input Parameters
        uint256 fundingGoalInWei = 0.02 ether;

        vm.startBroadcast();

        // Step 1: Deploy the UUPS Proxy with UUPSCrowdfundingCampaign logic
        address proxy = Upgrades.deployUUPSProxy(
            "UUPSCrowdfundingCampaign.sol",
            abi.encodeCall(UUPSCrowdfundingCampaign.initialize, (fundingGoalInWei))
        );

        console.log("Proxy address: ", proxy);

        // Step 2: Upgrade the proxy to V2_UUPSCrowdfundingCampaign
        Upgrades.upgradeProxy(
            proxy,
            "V2_UUPSCrowdfundingCampaign.sol",
            abi.encodeCall(V2_UUPSCrowdfundingCampaign.initializeV2, (3600)) // Initialize V2 with 1 hour duration
        );

        console.log("UUPS proxy upgraded to V2.");

        vm.stopBroadcast();
    }
}
