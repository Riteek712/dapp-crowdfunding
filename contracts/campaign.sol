// SPDX-License-Identifier: Unlicensed

// SPDX-License-Identifier: MIT
pragma solidity  >0.7.0 <=0.9.0;

contract CampaignFactory{

    address[] public  deployedCamps;

    event  campaignCreated(
        string title,
        uint requiredAmount,
        address indexed  owner,
        address campAddress,
        string imgURI,
        uint indexed timestamp,
        string indexed  category
    );

    function createCampaign(
        string memory campaignTitle,
        uint  requiredCampaignAmount,
        string memory imgURI,
        string memory storyURI,
        string memory category
    ) public {
        Campaign newCamp = new Campaign(
            campaignTitle, requiredCampaignAmount, 
            imgURI, storyURI);

        deployedCamps.push(address(newCamp));

        emit campaignCreated(
            campaignTitle, 
            requiredCampaignAmount,
            msg.sender,
            address(newCamp) , 
            imgURI, 
            block.timestamp, 
            category
        );
    }
}

contract Campaign {
    string public title = "Campaign Test";
    uint public requiredAmount;
    string public image;
    string public story;
    address payable  public owner;
    uint public recivedAmount ;

    event donated( address indexed donar,
    uint  indexed amount ,
    uint indexed  timestamp);




    constructor(
        string memory campaignTitle,
        uint requiredCampaignAmount,
        string memory imgURI,
        string memory storyURI
    ){
        title  = campaignTitle;
        requiredAmount = requiredCampaignAmount;
        image = imgURI;
        story = storyURI;

        owner = payable (msg.sender);

    }

    function donate( )public payable  {
        require(requiredAmount > recivedAmount, "Required amount fullfilled");
        owner.transfer(msg.value);
        recivedAmount += msg.value;
        emit  donated(msg.sender, msg.value, block.timestamp);

    }
}