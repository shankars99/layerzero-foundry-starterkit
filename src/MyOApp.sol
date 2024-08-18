// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {OApp, MessagingFee, Origin} from "@layerzerolabs/lz-evm-oapp-v2/contracts/oapp/OApp.sol";
import {MessagingReceipt} from "@layerzerolabs/lz-evm-oapp-v2/contracts/oapp/OAppSender.sol";

contract MyOApp is OApp {
    string public data;

    constructor(address _endpoint, address _delegate) OApp(_endpoint, _delegate) Ownable() {
        data = "init";
    }

    function send(uint32 _dstEid, string memory _message, bytes calldata _bgpRoute)
        public
        payable
        returns (MessagingReceipt memory receipt)
    {
        bytes memory payload = abi.encode(_message);
        receipt = _lzSend(_dstEid, payload, _bgpRoute, MessagingFee(msg.value, 0), payable(msg.sender));
    }

    function quote(uint32 _dstEid, string memory _message, bytes calldata _bgpRoute, bool _payInLzToken)
        public
        view
        returns (MessagingFee memory fee)
    {
        bytes memory payload = abi.encode(_message);
        fee = _quote(_dstEid, payload, _bgpRoute, _payInLzToken);
    }

    function _lzReceive(Origin calldata, bytes32, bytes calldata payload, address, bytes calldata) internal override {
        data = abi.decode(payload, (string));
    }
}
