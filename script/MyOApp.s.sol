// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {MyOApp} from "../src/MyOApp.sol";

contract MyOAppScript is Script {
    MyOApp public myOApp;

    // Configure these two values
    address endpoint;
    address delegate;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        myOApp = new MyOApp(endpoint, delegate);

        vm.stopBroadcast();
    }
}
