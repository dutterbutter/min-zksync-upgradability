// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "forge-std/Script.sol";
import "../src/CrowdfundingCampaignV2.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

// Part 2 of 2: Deploy the transparent proxy using the previously deployed implementation contract address.
// Deploys the transparent proxy using the previously deployed implementation contract address and logs the address of the deployed transparent proxy.
contract SuccessDeployTransparentProxy is Script {

    function run() public {
        vm.startBroadcast();
        // TODO: manually update address?
        address crowdfundingCampaignImplementation = 0xDe20FbB073Dd06d39A72Fe710CdCd704E38AA371;

        uint256 fundingGoalInWei = 0.02 ether;
        bytes memory initData = abi.encodeWithSelector(
            CrowdfundingCampaignV2.initialize.selector,
            fundingGoalInWei
        );

        ERC1967Proxy proxy = new ERC1967Proxy(crowdfundingCampaignImplementation, initData);
        console.log("Deployed Transparent Proxy at:", address(proxy));

        vm.stopBroadcast();
    }
 
}