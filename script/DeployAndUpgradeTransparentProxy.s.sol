// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "forge-std/Script.sol";
import {ProxyableCrowdfundingCampaign} from "../src/ProxyableCrowdfundingCampaign.sol";
import {V2_ProxyableCrowdfundingCampaign} from "../src/V2_ProxyableCrowdfundingCampaign.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";

contract DeployAndUpgradeTransparentProxy is Script {

    function run() public {
        // Input Parameters
        uint256 fundingGoalInWei = 0.02 ether;
        
        vm.startBroadcast();

        // Step 1: Deploy the Transparent Proxy with CrowdfundingCampaignV1 logic
        address _proxyAddress = Upgrades.deployTransparentProxy(
            "ProxyableCrowdfundingCampaign.sol",
            msg.sender, // Proxy Admin, usually the owner of the contract
            abi.encodeCall(ProxyableCrowdfundingCampaign.initialize, (fundingGoalInWei))
        );

        address implementationAddress = Upgrades.getImplementationAddress(_proxyAddress);
        console.log("Proxy address: ", _proxyAddress);
        console.log("Implementation address: ", implementationAddress);

        // Step 2: Upgrade the proxy to CrowdfundingCampaignV2 without calling any initializer function
        Upgrades.upgradeProxy(
            _proxyAddress,
            "V2_ProxyableCrowdfundingCampaign.sol",
            "" // No initializer called during upgrade
        );

        console.log("Transparent proxy upgraded to V2.");

        // Step 3: Call initializeV2 from the current broadcaster (assumed to be the owner)
        V2_ProxyableCrowdfundingCampaign(_proxyAddress).initializeV2(3600); // Call initializeV2 with a 1-hour duration

        console.log("V2 initialized by owner with new deadline.");

        vm.stopBroadcast();
    }
}
