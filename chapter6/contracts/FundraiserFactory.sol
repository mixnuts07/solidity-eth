// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
import "./Fundraiser.sol";

contract FundraiserFactory{
    FundRaiser[] private _fundraisers;

    function createFundraiser(
        string memory name,
        string memory url,
        string memory imageURL,
        string memory description,
        address payable beneficiary
    )
    public{
        FundRaiser fundraiser = new FundRaiser(
            name,
            url,
            imageURL,
            description,
            beneficiary,
            msg.sender
        );
        _fundraisers.push(fundraiser);
    }
    function fundraisersCount() public view returns(uint256) {
        return _fundraisers.length;
    }
}

