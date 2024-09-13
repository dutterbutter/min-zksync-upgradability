// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "forge-std/Script.sol";
import {ProxyableCrowdfundingCampaign} from "../src/ProxyableCrowdfundingCampaign.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";

contract DeployAndUpgradeBeaconProxy is Script {

    function run() public {
        // Input Parameters
        uint256 fundingGoalInWei = 0.02 ether;
       
        vm.startBroadcast();
        
        // Deploy the Beacon contract
        address _beaconAddress = Upgrades.deployBeacon("ProxyableCrowdfundingCampaign.sol", msg.sender);

        // Deploy the Beacon Proxy
        address proxy = Upgrades.deployBeaconProxy(
            _beaconAddress,
            abi.encodeCall(ProxyableCrowdfundingCampaign.initialize, (fundingGoalInWei))
        );

        console.log("Beacon address: ", _beaconAddress);
        console.log("Proxy address: ", proxy);

        Upgrades.upgradeBeacon(_beaconAddress, "V2_ProxyableCrowdfundingCampaign.sol");
        console.log("Beacon upgraded to new implementation.");

        vm.stopBroadcast();
    }
}

