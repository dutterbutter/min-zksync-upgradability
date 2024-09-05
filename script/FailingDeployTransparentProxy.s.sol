// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "forge-std/Script.sol";
import "../src/CrowdfundingCampaignV2.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";

// Expected to fail given `Upgrades.deployTransparentProxy` makes use deploys the implementation contract from bytecode before our compiler is aware of the bytecode resulting in `ERC1967InvalidImplementation`. 
// To see the error message, run `cast 4byte 0x4c9c8ce3`.  
contract FailingDeployTransparentProxy is Script {

    function run() public {
        vm.startBroadcast();
        uint256 fundingGoalInWei = 0.02 ether;
       
        console.log("Deploying Transparent Proxy for CrowdfundingCampaignV2...");
        address _proxyAddress = Upgrades.deployTransparentProxy(
            "CrowdfundingCampaignV2.sol",
            msg.sender,
            abi.encodeCall(CrowdfundingCampaignV2.initialize, (fundingGoalInWei))
        );
        console.log("Proxy deployed at:", _proxyAddress);
        address implementationAddress = Upgrades.getImplementationAddress(_proxyAddress);
        console.log("Implementation address deployed at:", implementationAddress);
 
 
        vm.stopBroadcast();
    }
 
}